class PurchaseService
  def initialize
  end

  def create(product, current_user)
    create_purchase(product, current_user)
    charge_by_qr(@purchase)
  end

  def confirm_payment(payment)
    @purchase = payment.purchase
    approved = MercadoPagoService.new(@purchase.user, @purchase).check_payment_status(payment.transaction_id)
    if approved
      payment.update!(status: 'paid', paid_at: Time.current)
      @purchase.update!(state: :paid)
    end
    approved
  end

  private

  def charge_by_qr(purchase)
    charge_info = charge_via_mercadopago(purchase)
    create_payment(purchase, charge_info)
    charge_info.merge(payment_id: @payment.id).except(:transaction_id)
  end

  def create_payment(purchase, charge_info)
    @payment = purchase.payments.find_or_initialize_by(amount: purchase.price, payment_method: 'pix', status: 'opened')
    @payment.transaction_id = charge_info[:transaction_id]
    @payment.save!
  end

  def charge_via_mercadopago(purchase)
    MercadoPagoService.new(purchase.user, purchase).charge
  end

  def create_purchase(product, current_user)
    @purchase = Purchase.find_or_create_by(
      product: product,
      user: current_user,
      price: product.price,
      state: :added
    )
  end
end