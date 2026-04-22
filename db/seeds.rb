laranjeira = User.create(
    email: "laranjeinita@gmail.com", 
    document_cpf: CPF.generate,
    full_name: 'Laranjeira Bonita',
    nickname: 'Laranjeira Bonita',
    password: 'password'
) unless User.exists?(email: "laranjeinita@gmail.com")

fulano = User.create(
    email: "fulano@gmail.com", 
    document_cpf: CPF.generate,
    full_name: 'Fulano',
    nickname: 'Fulano Bonita',
    password: 'password'
) unless User.exists?(email: "fulano@gmail.com")

mean_standard_activity = Activity.find_or_create_by(
    title: 'Adivinha a Média',
    person_limit: 1500,
    game_type: :mean,
    start_at: Date.parse('2025-01-01 00:00:00'),
    end_at: Date.parse('2048-01-01 23:59:59')
)

median_standard_activity = Activity.find_or_create_by(
    title: 'Adivinha a Mediana',
    person_limit: 1500,
    game_type: :median,
    start_at: Date.parse('2025-01-01 00:00:00'),
    end_at: Date.parse('2048-01-01 23:59:59')
)

if Promotion.active_one.nil?
    new_promo = Promotion.create(
    off_type: :pix,
        title: "#{Promotion.count + 1}º Jogo",
        activity_id: mean_standard_activity.id,
        status: :pending,
        people_limit: 350,
        multi_rewards: [1000, 500, 300, 200]
    )

    new_promo.products.create(
        name: "Ingresso",
        category: :ticket,
        description: "Ingresso para o #{new_promo.title}",
        price: 10
    )

    new_promo.products.create(
        name: "Ingresso",
        category: :ticket,
        description: "Ingresso para o #{new_promo.title}",
        price: 19.0,
        multi_number: 2
    )

    new_promo.products.create(
        name: "Ingresso",
        category: :ticket,
        description: "Ingresso para o #{new_promo.title}",
        price: 27.0,
        multi_number: 3
    )

    new_promo.products.create(
        name: "Ingresso",
        category: :ticket,
        description: "Ingresso para o #{new_promo.title}",
        price: 42.8,
        multi_number: 5
    )

    new_promo.products.create(
        name: "Ingresso",
        category: :ticket,
        description: "Ingresso para o #{new_promo.title}",
        price: 78.8,
        multi_number: 10
    )


    10.times do |i|
        new_promo.participations.create(
            user_id: laranjeira.id,
            response: (0..1000).to_a.sample,
            nickname: "Fulano #{i}"
        )
    end

    10.times do |i|
        new_promo.participations.create(
            user_id: fulano.id,
            response: (0..1000).to_a.sample,
            nickname: "Fulano #{i}"
        )
    end
end