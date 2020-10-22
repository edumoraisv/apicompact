# frozen_string_literal: true

namespace :dev do
  task roles: :environment do
    roles = %i[
      admin
      teacher
      nde
      coordinator
      center_director
      pro_rector
    ]

    spinner = TTY::Spinner.new(':spinner Creating roles', format: :bouncing_ball)
    spinner.auto_spin

    roles.each do |role|
      Role.create(name: role)
    end

    spinner.success('(successful)')
  end
  desc 'Create user for each role'
  task users: :environment do
    roles = %i[
      admin
      teacher
      nde
      coordinator
      center_director
      pro_rector
    ]

    spinner = TTY::Spinner.new(':spinner Creating user for each role', format: :bouncing_ball)
    spinner.auto_spin

    roles.each do |role|
      user = User.create(email: "#{role}@example.com", password: 'password')
      role = Role.create(name: role)

      user.roles << role
    end

    spinner.success('(successful)')
  end

  desc 'Create 50 draft question for teacher@example.com'
  task questions: :environment do
    spinner = TTY::Spinner.new(':spinner Creating 50 draft questions for teacher@example.com', format: :bouncing_ball)
    spinner.auto_spin

    teacher = User.find_by(email: 'teacher@example.com')

    50.times do |_i|
      Objective.create(
        user_id: teacher.id,
        status: 'draft',
        difficulty: 'easy',
        bloom_taxonomy: 'remember',
        check_type: 'incomplete_affirmation'
      )
    end

    spinner.success('(successful)')
  end

  desc 'Create Category > SubCategory > Axis > Subject'
  task categories: :environment do
    spinner = TTY::Spinner.new(':spinner Creating Category > SubCategory > Axis > Subject', format: :bouncing_ball)
    spinner.auto_spin

    categories = [
      'Conhecimentos Básicos',
      'Modelagem e Simulação',
      'Engenharia e Banco de Dados',
      'Redes e Sistemas Operacionais',
      'Sistemas Inteligentes'
    ]

    axes = [
      'Algoritmos de Alto Desempenho',
      'Ciência, Tecnologia e Sociedade',
      'Sistemas de Software',
      'Infraestrutura de Sistemas Computacionais'
    ]

    subjects = [
      'Cálculo',
      'Geometria Analítica',
      'Álgebra Linear',
      'Probabilidade e Estatística',
      'Matemática Discreta',
      'Lógica Matemática',
      'Pesquisa Operacional',
      'Cálculo Numérico',
      'Física',
      'Algoritmos e Estruturas de Dados',
      'Projeto e Análise de Algoritmos',
      'Programação Estruturada',
      'Programação Orientada a Objetos',
      'Programação Funcional',
      'Programação Web',
      'Programação para Dispositivos ',
      'Engenharia de Software',
      'Banco de Dados',
      'Gerência de Projetos',
      'Arquitetura de Computadores',
      'Sistemas Digitais',
      'Sistemas Operacionais',
      'Redes de Computadores',
      'Compiladores',
      'Teoria da Computação',
      'Sistemas Inteligentes',
      'Robótica',
      'Computação Gráfica',
      'Processamento de Sinais'
    ]

    axis_subject_algoritmo_desempenho = [
      'Cálculo', 'Geometria Analítica', 'Álgebra Linear', 'Matemática Discreta', 'Pesquisa Operacional',
      'Algoritmos e Estruturas de Dados', 'Projeto e Análise de Algoritmos', 'Teoria da Computação',
      'Sistemas Inteligentes', 'Computação Gráfica', 'Processamento de Sinais'
    ]
    axis_subject_ciencia_tec_soci = [
      'Probabilidade e Estatística', 'Cálculo Numérico'
    ]
    axis_subject_sistema_software = [
      'Lógica Matemática', 'Programação Estruturada', 'Programação Orientada a Objetos',
      'Programação Funcional', 'Programação Web', 'Programação para Dispositivos Móveis',
      'Engenharia de Software', 'Banco de Dados', 'Gerência de Projetos'
    ]

    # Create categories
    categories.each do |category|
      Category.create(name: category)
    end

    # Create axes
    axes.each do |axis|
      Axis.create(name: axis)
    end

    # Create sub_categories
    # sub_categories.each do |sub_category|
    #   Category.create(name: sub_category)
    # end

    category_subject_conhecimentos_basicos = [
      'Cálculo',
      'Geometria Analítica',
      'Álgebra Linear',
      'Probabilidade e Estatística',
      'Matemática Discreta',
      'Lógica Matemática',
      'Pesquisa Operacional',
      'Algoritmos e Estruturas de Dados',
      'Projeto e Análise de Algoritmos',
      'Programação Estruturada',
      'Programação Orientada a Objetos',
      'Programação Funcional',
      'Programação Web',
      'Programação para Dispositivos Móveis',
      'Arquitetura de Computadores',
      'Sistemas Digitais '
    ]

    category_subject_modelagem_simluacao = [
      'Cálculo Numérico',
      'Física',
      'Compcategory_iladores',
      'Teoria da Computação',
      'Robótica',
      'Computação Gráfica',
      'Processamento de Sinais'
    ]

    category_subject_engenharia_banco_dados = [
      'Engenharia de Software',
      'Banco de Dados',
      'Gerência de Projetos'
    ]
    category_subject_redes_e_sistemas_op = [
      'Sistemas Operacionais',
      'Redes de Computadores'
    ]

    # category_subject_sistema_inteligente = [
    #   'Sistemas Inteligentes'
    # ]

    # Create subjects
    subjects.each do |subject|
      if subject.in?(axis_subject_algoritmo_desempenho)
        if subject.in?(category_subject_conhecimentos_basicos)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Algoritmos de Alto Desempenho').pluck(:id),
                         category_id: Category.where(name: 'Conhecimentos Básicos').pluck(:id))
        elsif subject.in?(category_subject_modelagem_simluacao)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Algoritmos de Alto Desempenho').pluck(:id),
                         category_id: Category.where(name: 'Modelagem e Simulação').pluck(:id))
        elsif subject.in?(category_subject_engenharia_banco_dados)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Algoritmos de Alto Desempenho').pluck(:id),
                         category_id: Category.where(name: 'Engenharia e Banco de Dados').pluck(:id))
        elsif subject.in?(category_subject_redes_e_sistemas_op)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Algoritmos de Alto Desempenho').pluck(:id),
                         category_id: Category.where(name: 'Redes e Sistemas Operacionais').pluck(:id))
        else
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Algoritmos de Alto Desempenho').pluck(:id),
                         category_id: Category.where(name: 'Sistemas Inteligentes').pluck(:id))
        end

      elsif subject.in?(axis_subject_ciencia_tec_soci)
        if subject.in?(category_subject_conhecimentos_basicos)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Ciência, Tecnologia e Sociedade').pluck(:id),
                         category_id: Category.where(name: 'Conhecimentos Básicos').pluck(:id))
        elsif subject.in?(category_subject_modelagem_simluacao)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Ciência, Tecnologia e Sociedade').pluck(:id),
                         category_id: Category.where(name: 'Modelagem e Simulação').pluck(:id))
        elsif subject.in?(category_subject_engenharia_banco_dados)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Ciência, Tecnologia e Sociedade').pluck(:id),
                         category_id: Category.where(name: 'Engenharia e Banco de Dados').pluck(:id))
        elsif subject.in?(category_subject_redes_e_sistemas_op)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Ciência, Tecnologia e Sociedade').pluck(:id),
                         category_id: Category.where(name: 'Redes e Sistemas Operacionais').pluck(:id))
        else
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Ciência, Tecnologia e Sociedade').pluck(:id),
                         category_id: Category.where(name: 'Sistemas Inteligentes').pluck(:id))
        end

      elsif subject.in?(axis_subject_sistema_software)
        if subject.in?(category_subject_conhecimentos_basicos)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Sistemas de Software').pluck(:id),
                         category_id: Category.where(name: 'Conhecimentos Básicos').pluck(:id))
        elsif subject.in?(category_subject_modelagem_simluacao)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Sistemas de Software').pluck(:id),
                         category_id: Category.where(name: 'Modelagem e Simulação').pluck(:id))
        elsif subject.in?(category_subject_engenharia_banco_dados)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Sistemas de Software').pluck(:id),
                         category_id: Category.where(name: 'Engenharia e Banco de Dados').pluck(:id))
        elsif subject.in?(category_subject_redes_e_sistemas_op)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Sistemas de Software').pluck(:id),
                         category_id: Category.where(name: 'Redes e Sistemas Operacionais').pluck(:id))
        else
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Sistemas de Software').pluck(:id),
                         category_id: Category.where(name: 'Sistemas Inteligentes').pluck(:id))
        end

      else
        if subject.in?(category_subject_conhecimentos_basicos)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Infraestrutura de Sistemas Computacionais').pluck(:id),
                         category_id: Category.where(name: 'Conhecimentos Básicos').pluck(:id))
        elsif subject.in?(category_subject_modelagem_simluacao)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Infraestrutura de Sistemas Computacionais').pluck(:id),
                         category_id: Category.where(name: 'Modelagem e Simulação').pluck(:id))
        elsif subject.in?(category_subject_engenharia_banco_dados)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Infraestrutura de Sistemas Computacionais').pluck(:id),
                         category_id: Category.where(name: 'Engenharia e Banco de Dados').pluck(:id))
        elsif subject.in?(category_subject_redes_e_sistemas_op)
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Infraestrutura de Sistemas Computacionais').pluck(:id),
                         category_id: Category.where(name: 'Redes e Sistemas Operacionais').pluck(:id))
        else
          Subject.create(name: subject,
                         axis_id: Axis.where(name: 'Infraestrutura de Sistemas Computacionais').pluck(:id),
                         category_id: Category.where(name: 'Sistemas Inteligentes').pluck(:id))
        end
      end
    end

    # axis = Axis.create(
    #   name: 'Algoritmos de Alto Desempenho'
    # )

    # category = Category.create(
    #   name: 'Conhecimentos Básicos'
    # )

    # Subject.create(
    #   name: 'Cálculo',
    #   axis_id: axis.id,
    #   category_id: category.id
    # )

    spinner.success('(successful)')
  end

  desc 'Reset database and run seeds'
  task setup: :environment do
    spinner = TTY::Spinner.new(':spinner Dropping database', format: :bouncing_ball)
    spinner.auto_spin
    `rails db:drop`
    spinner.success('(successful)')

    spinner = TTY::Spinner.new(':spinner Creating database', format: :bouncing_ball)
    spinner.auto_spin
    `rails db:create`
    spinner.success('(successful)')

    spinner = TTY::Spinner.new(':spinner Running database migrations', format: :bouncing_ball)
    spinner.auto_spin
    `rails db:migrate`
    spinner.success('(successful)')

    `rails dev:users`
    `rails dev:questions`
    `rails dev:categories`
  end
end
