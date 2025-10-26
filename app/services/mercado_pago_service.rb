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
    payment_data = get_payment_data
    payment = sdk.payment.create(payment_data)
    pix_qr_code = payment.dig(:response, 'point_of_interaction', 'transaction_data', 'qr_code')
    pix_qr_code_base64 = payment.dig(:response, 'point_of_interaction', 'transaction_data', 'qr_code_base64')
    transaction_id = payment.dig(:response, 'id')
    { qr_code: pix_qr_code, qr_base64: pix_qr_code_base64, transaction_id: transaction_id }
  rescue NoMethodError => e
    Rails.logger.error("Error retrieving result: #{e.message}")
    {}
  end

  def sdk
    MERCADOPAGO_SDK
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
