require 'mercadopago'
class MercadoPagoService
  def initialize(user, purchase)
    @user = user
    @purchase = purchase
  end

  def charge
    create_payment
  end

  def check_payment_status(transaction_id)
    payment = MERCADOPAGO_SDK.payment.get(transaction_id)
    payment.dig(:response, "status").eql?("approved")
  end

  private

  def create_payment
    return if Rails.env.development? 
    return active_transaction if active_transaction.present?
    payment_data = get_payment_data
    payment = sdk.payment.create(payment_data)
    qr_code = payment.dig(:response, 'point_of_interaction', 'transaction_data', 'qr_code')
    qr_base64 = payment.dig(:response, 'point_of_interaction', 'transaction_data', 'qr_code_base64')
    transaction_id = payment.dig(:response, 'id')
    create_transaction(qr_code, qr_base64, transaction_id)
  rescue NoMethodError => e
    Rails.logger.error("Error retrieving result: #{e.message}")
    {}
  end

  def create_transaction(qr_code, qr_base64, transaction_id)
    Transaction.create(
      transaction_id: transaction_id, 
      qr_code: qr_code, 
      qr_base64: qr_base64
    )
  end

  def active_transaction
    transaction_id = @purchase.payments.find_by(status: :opened)&.transaction_id
    return if transaction_id.nil?
    Transaction.where('created_at > ?', 30.minutes.ago).find_by(transaction_id: transaction_id)
  end

  def sdk
    Mercadopago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])    
  end

  def get_payment_data
    {
      transaction_amount: @purchase.price.to_f,
      description: @purchase.product.name,
      payment_method_id: 'pix',
      payer: {
        email: @user.email,
        first_name: @user.full_name,
        last_name: @user.nickname
      }
    }
  end
end
