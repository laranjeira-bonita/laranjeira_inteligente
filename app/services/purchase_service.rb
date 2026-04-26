class PurchaseService
  def initialize
  end

  def create(product, current_user)
    create_purchase(product, current_user)
    charge_by_qr
  end

  def confirm_payment(payment)
    @purchase = payment.purchase
    approved = MercadoPagoService.new(@purchase.user, @purchase).check_payment_status(payment.transaction_id)
    if approved
      payment.pay!
      @purchase.update!(state: :paid)
    end
    approved
  end

  private

  def charge_by_qr
    transaction = MercadoPagoService.new(@purchase.user, @purchase).charge
    create_payment(@purchase, transaction)
    return @payment
  end


  def pay_fake_payment!
    payment = Payment.create!(
      amount: 123,
      purchase: @purchase,
      payment_method: :pix,
      status: :opened,
      transaction_id: SecureRandom.uuid
    )
    payment.pay!
  end

  def create_payment(purchase, transaction)
    return pay_fake_payment! if Rails.env.development?
    @payment = purchase.payments.find_or_initialize_by(amount: purchase.price, payment_method: 'pix', status: 'opened')
    @payment.transaction_id = transaction.transaction_id
    @payment.save!
  end

  def price_with_ticker_discount(product, current_user)
    return product.price if @ticker.nil? || product.gift_card?
    return (product.price - @ticker.rate) if @ticker.gift_card?
    product.price * ((100 - @ticker.rate).to_f / 100)
  end
  
  def create_purchase(product, current_user)
    @ticker = current_user.best_ticker
    @purchase = Purchase.find_or_create_by(
      product: product,
      user: current_user,
      price: price_with_ticker_discount(product, current_user),
      state: :added
    )
    @purchase.update(ticker_id: @ticker.id) if @ticker.present?
    @ticker&.update(deleted_at: Time.current)
  end
end