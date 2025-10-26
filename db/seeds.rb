User.create(
    email: "laranjeinita@gmail.com", 
    document_cpf: CPF.generate,
    full_name: 'Laranjeira Bonita',
    nickname: 'Laranjeira Bonita',
    password: 'password'
)

Store.create(    
    name: 'Laranjeira Inteligente',
    document_cnpj: CNPJ.generate(14),
    user_id: User.first.id
)