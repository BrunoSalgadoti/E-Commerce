import 'package:brn_ecommerce/models/categories_of_products/product_category.dart';
import 'package:brn_ecommerce/models/categories_of_products/product_sub_category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Lista de categorias de produtos de fábrica.
///
/// Essa lista é usada para criar ou atualizar categorias de produtos no Firebase
/// Firestore durante o processo de inicialização do aplicativo. Ela é usada
/// principalmente em uma função de desenvolvedor para definir as categorias
/// iniciais ou atualizar as existentes.
///
/// ATENÇÃO: Modificar esta lista pode ter impacto direto na estrutura da loja
/// online, incluindo a criação, atualização e exclusão de categorias e subcategorias.
/// Se a loja já estiver em uso, modificações nesta lista devem ser feitas com
/// cuidado, levando em consideração o impacto nos produtos associados às categorias.
///
/// Esta lista é condicionalmente populada com categorias apenas quando o aplicativo
/// é executado em modo de desenvolvimento (kReleaseMode = false). No modo de produção,
/// a lista será vazia.

List<ProductCategory> categoriesFactoryList = kReleaseMode
    ? []
    : [
        ProductCategory(
          categoryID: "c1",
          categoryTitle: "Eletrônicos",
          categoryRealColor: const Color.fromARGB(255, 162, 0, 255),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [
            SubCategory(
              subCategoryID: "c1_s1",
              subCategoryTitle: 'Smartphones',
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s2",
              subCategoryTitle: "TVs",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s3",
              subCategoryTitle: "TESTE 2",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s4",
              subCategoryTitle: "TESTE 3",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s5",
              subCategoryTitle: "TESTE 4",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s6",
              subCategoryTitle: "TESTE 5",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s7",
              subCategoryTitle: 'TESTE 6',
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s8",
              subCategoryTitle: "TESTE 7",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s9",
              subCategoryTitle: "TESTE 8",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s10",
              subCategoryTitle: "TESTE 9",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s11",
              subCategoryTitle: "TESTE 10",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c1_s12",
              subCategoryTitle: "TESTE 11",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s1",
              subCategoryTitle: 'TESTE',
              iconSubCategories: "",
            ),
          ],
        ),
        ProductCategory(
          categoryID: "c2",
          categoryTitle: "Eletro-Domesticos",
          categoryRealColor: const Color.fromARGB(255, 0, 255, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [
            SubCategory(
              subCategoryID: "c2_s2",
              subCategoryTitle: "TESTE 1",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s3",
              subCategoryTitle: "TESTE 2",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s4",
              subCategoryTitle: "TESTE 3",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s5",
              subCategoryTitle: "TESTE 4",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s6",
              subCategoryTitle: "TESTE 5",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_7",
              subCategoryTitle: 'TESTE 6',
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_8",
              subCategoryTitle: "TESTE 7",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s9",
              subCategoryTitle: "TESTE 8",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_10",
              subCategoryTitle: "TESTE 9",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s11",
              subCategoryTitle: "TESTE 10",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c2_s12",
              subCategoryTitle: "TESTE 11",
              iconSubCategories: "",
            ),
          ],
        ),
        ProductCategory(
          categoryID: "c3",
          categoryTitle: "Móveis",
          categoryRealColor: const Color.fromARGB(255, 107, 101, 48),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [
            SubCategory(
              subCategoryID: "c3_s1",
              subCategoryTitle: 'TESTE',
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s2",
              subCategoryTitle: "TESTE 1",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s3",
              subCategoryTitle: "TESTE 2",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s4",
              subCategoryTitle: "TESTE 3",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s5",
              subCategoryTitle: "TESTE 4",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s6",
              subCategoryTitle: "TESTE 5",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s7",
              subCategoryTitle: 'TESTE 6',
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s8",
              subCategoryTitle: "TESTE 7",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s9",
              subCategoryTitle: "TESTE 8",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s10",
              subCategoryTitle: "TESTE 9",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s11",
              subCategoryTitle: "TESTE 10",
              iconSubCategories: "",
            ),
            SubCategory(
              subCategoryID: "c3_s12",
              subCategoryTitle: "TESTE 11",
              iconSubCategories: "",
            )
          ],
        ),
        ProductCategory(
          categoryID: "c4",
          categoryTitle: "Imóveis",
          categoryRealColor: const Color.fromARGB(255, 255, 255, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c5",
          categoryTitle: "Esportivos",
          categoryRealColor: const Color.fromARGB(255, 255, 0, 255),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c6",
          categoryTitle: "Vestuário",
          categoryRealColor: const Color.fromARGB(255, 0, 255, 255),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c7",
          categoryTitle: "Arte e Artesanato",
          categoryRealColor: const Color.fromARGB(255, 164, 192, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c8",
          categoryTitle: "Alimentos e Bebidas",
          categoryRealColor: const Color.fromARGB(255, 255, 165, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c9",
          categoryTitle: "Papelaria e Livraria",
          categoryRealColor: const Color.fromARGB(255, 0, 128, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c10",
          categoryTitle: "Armarinho",
          categoryRealColor: const Color.fromARGB(255, 194, 239, 252),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c11",
          categoryTitle: "Eventos e Shows",
          categoryRealColor: const Color.fromARGB(255, 253, 252, 252),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c12",
          categoryTitle: "Lazer",
          categoryRealColor: const Color.fromARGB(255, 0, 128, 128),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c13",
          categoryTitle: "Escolares e Educacional",
          categoryRealColor: const Color.fromARGB(255, 0, 255, 255),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c14",
          categoryTitle: "Volta às aulas",
          categoryRealColor: const Color.fromARGB(255, 255, 0, 128),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c15",
          categoryTitle: "Beleza e Cuidado Pessoal",
          categoryRealColor: const Color.fromARGB(255, 255, 0, 251),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c16",
          categoryTitle: "Saúde",
          categoryRealColor: const Color.fromARGB(254, 62, 255, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c17",
          categoryTitle: "Ferramentas",
          categoryRealColor: const Color.fromARGB(255, 88, 115, 124),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c18",
          categoryTitle: "Serviços",
          categoryRealColor: const Color.fromARGB(255, 0, 0, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c19",
          categoryTitle: "Antiguidades e Coleções",
          categoryRealColor: const Color.fromARGB(255, 255, 165, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c20",
          categoryTitle: "Jogos, Brinquedos e Diversão",
          categoryRealColor: const Color.fromARGB(255, 0, 0, 255),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c21",
          categoryTitle: "Hobbies",
          categoryRealColor: const Color.fromARGB(255, 128, 0, 128),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c22",
          categoryTitle: "Promoções",
          categoryRealColor: const Color.fromARGB(255, 0, 128, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c23",
          categoryTitle: "Do Lar",
          categoryRealColor: const Color.fromARGB(255, 128, 128, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c24",
          categoryTitle: "Bebês e Crianças",
          categoryRealColor: const Color.fromARGB(255, 115, 81, 81),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c25",
          categoryTitle: "Melhor idade",
          categoryRealColor: const Color.fromARGB(255, 0, 128, 128),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c26",
          categoryTitle: "Informática",
          categoryRealColor: const Color.fromARGB(255, 192, 192, 192),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c27",
          categoryTitle: "Fitness",
          categoryRealColor: const Color.fromARGB(255, 191, 239, 141),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c28",
          categoryTitle: "Indústria e Comércio",
          categoryRealColor: const Color.fromARGB(255, 253, 0, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c29",
          categoryTitle: "Instrumentos Musicais",
          categoryRealColor: const Color.fromARGB(255, 0, 0, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c30",
          categoryTitle: 'Áudio e Vídeo',
          categoryRealColor: const Color.fromARGB(255, 253, 105, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c31",
          categoryTitle: 'Adultos (18+)',
          categoryRealColor: const Color.fromARGB(255, 0, 0, 255),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c32",
          categoryTitle: "Perfumaria",
          categoryRealColor: const Color.fromARGB(255, 128, 0, 128),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c33",
          categoryTitle: "Animais",
          categoryRealColor: const Color.fromARGB(255, 255, 0, 0),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c34",
          categoryTitle: "Eletrônicos de Consumo",
          categoryRealColor: const Color.fromARGB(255, 72, 146, 255),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c35",
          categoryTitle: "Produtos Personalizados",
          categoryRealColor: const Color.fromARGB(255, 189, 179, 179),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c36",
          categoryTitle: "Acessórios Fashion",
          categoryRealColor: const Color.fromARGB(255, 139, 255, 72),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c37",
          categoryTitle: 'Complementos de Moda',
          categoryRealColor: const Color.fromARGB(255, 253, 252, 252),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
        ProductCategory(
          categoryID: "c38",
          categoryTitle: "Acessórios para Looks",
          categoryRealColor: const Color.fromARGB(255, 255, 191, 72),
          categoryImg: null,
          categoryActivated: false,
          subCategoryList: [],
        ),
      ];
