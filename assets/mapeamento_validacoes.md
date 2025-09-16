# Mapeamento de Validações e Funções

| Signature | File | Type | Description |
|----------|------|------|-------------|
| AdvertisingWidget | lib/common\advertising\advertising_widget.dart | class | Classe presente em lib/common\advertising\advertising_widget.dart |
| AdvertisingWidgetState | lib/common\advertising\advertising_widget.dart | class | Classe presente em lib/common\advertising\advertising_widget.dart |
| AdvertisingWidget({super.key}) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| createState() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| AdvertisingWidgetState() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| ProductManager() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| PageController() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| initState() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| initState() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| addListener(() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| setState(() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| round() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| periodic(const Duration(seconds: 9) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| UtilsForAdvertising() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| loadAdvertisingProducts(productManager) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| UtilsForAdvertising() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| loadAdminSelectedImages() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| nextPage(
          duration: const Duration(seconds: 2) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| jumpToPage(0) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| build(BuildContext context) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| getTextColorBasedOnBackground(Theme.of(context) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| UtilsForAdvertising() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| loadAdvertisingProducts(productManager) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| where((p) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| toList() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| UtilsForAdvertising() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| loadAdminSelectedImages() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| where((p) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| toList() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| ceil() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| LayoutBuilder(builder: (context, constraints) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| Column(
        children: [
          SizedBox(
            height: constraints.maxWidth < mobileBreakpoint
                ? 280
                : constraints.maxWidth >= wildBreakpoint
                    ? 580
                    : 390,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(children: [
                PageView(
                  controller: _pageController,
                  padEnds: true,
                  children: [
                    //Selection of map content to be displayed on the Advertising Card...
                    // (cardContents or imageContents) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| AdvertisingCard(product: content.product!) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| AdvertisingCard(product: product) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| network(content.imageUrl!) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (kIsWeb) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| Center(
                        child: FloatingActionButton(
                          heroTag: 'previousButton',
                          mini: true,
                          onPressed: () | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| previousPage(
                                duration: const Duration(milliseconds: 300) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| FittedBox(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 14,
                            ) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| Center(
                        child: FloatingActionButton(
                          heroTag: 'nextButton',
                          mini: true,
                          onPressed: () | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| nextPage(
                                duration: const Duration(milliseconds: 300) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| jumpToPage(0) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| FittedBox(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 14,
                            ) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| Padding(
                    padding: const EdgeInsets.only(right: 3) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? padEndsColor : Colors.black45,
                      ) | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| dispose() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| dispose() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| cancel() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| dispose() | lib/common\advertising\advertising_widget.dart | common | Função/método em lib/common\advertising\advertising_widget.dart |
| BestSellingCard | lib/common\advertising\best_selling_card.dart | class | Classe presente em lib/common\advertising\best_selling_card.dart |
| _BestSellingCardState | lib/common\advertising\best_selling_card.dart | class | Classe presente em lib/common\advertising\best_selling_card.dart |
| _HoverableProductCard | lib/common\advertising\best_selling_card.dart | class | Classe presente em lib/common\advertising\best_selling_card.dart |
| _HoverableProductCardState | lib/common\advertising\best_selling_card.dart | class | Classe presente em lib/common\advertising\best_selling_card.dart |
| BestSellingCard({super.key}) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| createState() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| _BestSellingCardState() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| ScrollController() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| _scrollLeft() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| animateTo(
      _scrollController.offset - 200,
      duration: const Duration(milliseconds: 300) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| _scrollRight() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| animateTo(
      _scrollController.offset + 200,
      duration: const Duration(milliseconds: 300) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| build(BuildContext context) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| getBestSellingProducts(15) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| shrink() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: tabletBreakpoint,
        ) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| Card(
          color: Colors.amber[200],
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| RoundedRectangleBorder(borderRadius: BorderRadius.circular(12) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| withAlpha((0.6 * 255) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| toInt() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| Padding(
            padding: const EdgeInsets.all(12.0) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textForGoogleDecorations(titleForDecorations: 'Mais Vendidos') | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| SizedBox(height: 12) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      ListView.separated(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: bestSellingProducts.length,
                        separatorBuilder: (_, __) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| SizedBox(width: 3) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| _HoverableProductCard(product: product) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| _HoverableProductCard({required this.product}) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| createState() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| _HoverableProductCardState() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| build(BuildContext context) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| MouseRegion(
      onEnter: (_) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| setState(() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| setState(() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| AnimatedContainer(
        duration: const Duration(milliseconds: 200) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| symmetric(horizontal: 1) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| Card(
          elevation: _hovering ? 12 : 4,
          color: Colors.amber[100],
          shadowColor: Colors.amber[400]?.withAlpha((0.6 * 255) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| toInt() | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| RoundedRectangleBorder(borderRadius: BorderRadius.circular(12) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| GestureDetector(
            onTap: () | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| pushNamed(
                context,
                RoutesNavigator.productDetailsScreen,
                arguments: widget.product,
              ) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| ItemTile(product: widget.product) | lib/common\advertising\best_selling_card.dart | common | Função/método em lib/common\advertising\best_selling_card.dart |
| CategoriesShowcase | lib/common\advertising\categories_showcase.dart | class | Classe presente em lib/common\advertising\categories_showcase.dart |
| HoverableCategoryItem | lib/common\advertising\categories_showcase.dart | class | Classe presente em lib/common\advertising\categories_showcase.dart |
| _HoverableCategoryItemState | lib/common\advertising\categories_showcase.dart | class | Classe presente em lib/common\advertising\categories_showcase.dart |
| CategoriesShowcase({super.key}) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| build(BuildContext context) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| filterCategoriesActivated(
      userManager.adminEnable,
      false,
    ) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| shrink() | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: tabletBreakpoint,
        ) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| textForGoogleDecorations(titleForDecorations: 'Visite nossas categorias') | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| SizedBox(height: 10) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| LayoutBuilder(
              builder: (context, constraints) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 2,
                  children: activeCategories.map((category) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| HoverableCategoryItem(
                      productCategory: category,
                      cardWidth: cardWidth,
                      cardHeight: cardHeight,
                    ) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| toList() | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| SizedBox(height: 20) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| HoverableCategoryItem({
    super.key,
    this.productCategory,
    this.cardWidth,
    this.cardHeight,
  }) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| createState() | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| _HoverableCategoryItemState() | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| build(BuildContext context) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| MouseRegion(
      onEnter: (_) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| setState(() | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| setState(() | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| Column(
        children: [
          AnimatedScale(
            scale: _isHovered ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 250) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| SizedBox(
              width: width,
              height: height,
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(99) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| circular(99) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| InkWell(
                  onTap: () | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| of(context) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| pushNamed(
                      RoutesNavigator.categoryProductsScreen,
                      arguments: widget.productCategory!,
                    ) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| buildCategoryImage(productCategory: widget.productCategory!) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| SizedBox(height: 8) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| textForGoogleDecorations(
            titleForDecorations: widget.productCategory?.categoryTitle ?? "",
            fontMethod: GoogleFonts.rancho,
            fillColor: getTextColorBasedOnBackground(Colors.yellow.withAlpha(90) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| getBorderColorInvertedTextColor(Colors.orange) | lib/common\advertising\categories_showcase.dart | common | Função/método em lib/common\advertising\categories_showcase.dart |
| AdvertisingCard | lib/common\advertising\components\advertising\advertising_card.dart | class | Classe presente em lib/common\advertising\components\advertising\advertising_card.dart |
| to | lib/common\advertising\components\advertising\advertising_card.dart | class | Classe presente em lib/common\advertising\components\advertising\advertising_card.dart |
| AdvertisingCard({super.key, required this.product}) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| build(BuildContext context) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| GestureDetector(
      onTap: () | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| pushNamed(context, RoutesNavigator.productDetailsScreen, arguments: product) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| LayoutBuilder(builder: (context, constraints) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| Stack(
          children: [
            ///Card Background wallpaper
            Card(
              elevation: 7,
              clipBehavior: Clip.antiAlias,
              semanticContainer: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| circular(20.0) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| Container(
                clipBehavior: Clip.antiAlias,
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(RootAssets.imageForEmptyBackgroundsJpg) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| Center(
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: double.infinity,
                width: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50) | lib/common\advertising\components\advertising\advertising_card.dart | common | Container Product Photo |
| circular(50) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| network(
                    product.images!.first,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitHeight,
                  ) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| Padding(
              padding: EdgeInsets.only(left: constraints.maxWidth * 0.15, bottom: 25) | lib/common\advertising\components\advertising\advertising_card.dart | common | Ad price tag |
| TagForCard(
                data: 'A partir:\n '
                    '${formattedRealText(product.basePrice) | lib/common\advertising\components\advertising\advertising_card.dart | common | Função/método em lib/common\advertising\components\advertising\advertising_card.dart |
| AdvertisingCarouselContent | lib/common\advertising\components\advertising\content_type.dart | class | Classe presente em lib/common\advertising\components\advertising\content_type.dart |
| AdvertisingCarouselContent({
    required this.type,
    this.product,
    this.imageUrl,
  }) | lib/common\advertising\components\advertising\content_type.dart | common | Função/método em lib/common\advertising\components\advertising\content_type.dart |
| for | lib/common\advertising\components\advertising\utils_for_advertising.dart | class | Classe presente em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| UtilsForAdvertising | lib/common\advertising\components\advertising\utils_for_advertising.dart | class | Classe presente em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| loadAdvertisingProducts(ProductManager productManager) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| where((product) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| where((p) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| toList() | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| map((product) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| AdvertisingCarouselContent(
              type: ContentType.productCard,
              product: product,
            ) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| where((p) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| toList() | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| loadAdminSelectedImages() | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| map((imageUrl) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| AdvertisingCarouselContent(
              type: ContentType.image16x9,
              imageUrl: imageUrl,
            ) | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| toList() | lib/common\advertising\components\advertising\utils_for_advertising.dart | common | Função/método em lib/common\advertising\components\advertising\utils_for_advertising.dart |
| AnimatedHighlightTitle | lib/common\advertising\components\highlight\animated_highlight_title.dart | class | Classe presente em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| _AnimatedHighlightTitleState | lib/common\advertising\components\highlight\animated_highlight_title.dart | class | Classe presente em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| AnimatedHighlightTitle({
    super.key,
    this.title = 'DESTAQUES',
    this.fontSize = 16,
  }) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| createState() | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| _AnimatedHighlightTitleState() | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| initState() | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| initState() | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| repeat(reverse: true) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| dispose() | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| dispose() | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| dispose() | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| build(BuildContext context) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| Center(
            child: textForGoogleDecorations(
              titleForDecorations: widget.title,
            ) | lib/common\advertising\components\highlight\animated_highlight_title.dart | common | Função/método em lib/common\advertising\components\highlight\animated_highlight_title.dart |
| HighlightProductCard | lib/common\advertising\components\highlight\highlight_product_card.dart | class | Classe presente em lib/common\advertising\components\highlight\highlight_product_card.dart |
| _HighlightProductCardState | lib/common\advertising\components\highlight\highlight_product_card.dart | class | Classe presente em lib/common\advertising\components\highlight\highlight_product_card.dart |
| HighlightProductCard({
    super.key,
    this.product,
    this.images,
    this.name,
    this.price,
    required this.onTap,
  }) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| createState() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| _HighlightProductCardState() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| formattedRealText(widget.product!.basePrice) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| toStringAsFixed(2) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| initState() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| initState() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| PageController() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| periodic(const Duration(seconds: 2) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| dispose() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| cancel() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| dispose() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| dispose() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| build(BuildContext context) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 180,
        maxWidth: 200,
        minHeight: 250,
        maxHeight: 294,
      ) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| GestureDetector(
        onTap: widget.onTap,
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animated Title
              const AnimatedHighlightTitle() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| Padding(
                padding: const EdgeInsets.all(8.0) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| Text(
                  _name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(12) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| SizedBox(
                  height: 160 * 1.07,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _images.length > 3 ? 3 : _images.length,
                    physics: const NeverScrollableScrollPhysics() | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| network(
                        _images[index],
                        fit: BoxFit.fitHeight,
                      ) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| Padding(
                padding: const EdgeInsets.all(8.0) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| Center(
                  child: Text(
                    _priceText,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                    ) | lib/common\advertising\components\highlight\highlight_product_card.dart | common | Função/método em lib/common\advertising\components\highlight\highlight_product_card.dart |
| responsible | lib/common\advertising\components\products_best_selling.dart | class | Classe presente em lib/common\advertising\components\products_best_selling.dart |
| handles | lib/common\advertising\components\products_best_selling.dart | class | Classe presente em lib/common\advertising\components\products_best_selling.dart |
| ProductsBestSelling | lib/common\advertising\components\products_best_selling.dart | class | Classe presente em lib/common\advertising\components\products_best_selling.dart |
| ProductsBestSelling({
    required this.allProducts,
    this.salesThreshold = 15,
  }) | lib/common\advertising\components\products_best_selling.dart | common | and the optional [salesThreshold] parameter sets the minimum sales margin for a product to be considered best-selling. |
| getBestSellingProducts(int count) | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| where((p) | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| toList() | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| sort((a, b) | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| compareTo(a.totalSellers) | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| take(count) | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| toList() | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| updateBestSellingProductsIfNeeded() | lib/common\advertising\components\products_best_selling.dart | common | Updates the list of best-selling products if needed. |
| getBestSellingProducts(allProducts.length) | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| _areListsEqual(updatedProducts, bestSellingProducts) | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| notifyListeners() | lib/common\advertising\components\products_best_selling.dart | common | Função/método em lib/common\advertising\components\products_best_selling.dart |
| _areListsEqual(List<Product> list1, List<Product> list2) | lib/common\advertising\components\products_best_selling.dart | bool | Returns true if the lists are equal, false otherwise. |
| ProductsLowestSelling | lib/common\advertising\components\products_lowest_selling.dart | class | Classe presente em lib/common\advertising\components\products_lowest_selling.dart |
| ProductsLowestSelling({required this.allProducts, this.minimumSellers = 0}) | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| getLowestSellingProducts({int count = 15}) | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| now() | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| subtract(const Duration(days: 14) | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| where((p) | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| toDate() | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| isBefore(twoWeeksAgo) | lib/common\advertising\components\products_lowest_selling.dart | getter | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| toList() | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| sort((a, b) | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| compareTo(b.totalSellers) | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| take(count) | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| toList() | lib/common\advertising\components\products_lowest_selling.dart | common | Função/método em lib/common\advertising\components\products_lowest_selling.dart |
| responsible | lib/common\advertising\components\products_recently_added.dart | class | Classe presente em lib/common\advertising\components\products_recently_added.dart |
| handles | lib/common\advertising\components\products_recently_added.dart | class | Classe presente em lib/common\advertising\components\products_recently_added.dart |
| ProductsRecentlyAdded | lib/common\advertising\components\products_recently_added.dart | class | Classe presente em lib/common\advertising\components\products_recently_added.dart |
| ProductsRecentlyAdded({required this.allProducts}) | lib/common\advertising\components\products_recently_added.dart | common | /// The [allProducts] parameter represents the list of all available products. |
| getRecentProducts({int count = 10, required ProductCategory? productCategory}) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| where(
              (p) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| take(10) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| toList() | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| where((p) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| toList() | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| sort((a, b) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| now() | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| now() | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| compareTo(aInsertion) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| take(15) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| toList() | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| updateRecentProducts({
    int count = 15,
    ProductCategory? productCategory,
  }) | lib/common\advertising\components\products_recently_added.dart | common | /// Optional parameters [withCategory] and [productCategory] filter by category if needed. |
| getRecentProducts(
      count: count,
      productCategory: productCategory,
    ) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| _areListsEqual(updatedProducts, _recentProducts) | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| notifyListeners() | lib/common\advertising\components\products_recently_added.dart | common | Função/método em lib/common\advertising\components\products_recently_added.dart |
| _areListsEqual(List<Product> list1, List<Product> list2) | lib/common\advertising\components\products_recently_added.dart | bool | Checks whether two lists of products are equal by comparing their IDs. |
| PurchaseModel | lib/common\advertising\components\purchase_model.dart | class | Classe presente em lib/common\advertising\components\purchase_model.dart |
| PurchaseModel({
    required this.userId,
    required this.items,
    required this.createdAt,
  }) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| toMap() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| fromDate(createdAt) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| fromMap(Map<String, dynamic> map) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| PurchaseModel(
      userId: map['userId'] ?? '',
      items: List<String>.from(map['items'] ?? []) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| toDate() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| savePurchase(PurchaseModel purchase) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| collection('aux') | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| doc('purchases') | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| set({}, SetOptions(merge: true) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| collection('items') | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| doc(purchase.userId) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| get() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| update({
        'items': FieldValue.arrayUnion(purchase.items) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| now() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| set({
        'userId': purchase.userId,
        'items': purchase.items,
        'createdAt': DateTime.now() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| now() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| getUserPurchasedItems(String userId) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| collection('aux') | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| doc('purchases') | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| collection('items') | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| doc(userId) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| get() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| data() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| getPurchaseSuggestions({
    required String userId,
    required List<Product> allProducts,
    int suggestionCount = 24,
  }) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| getUserPurchasedItems(userId) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| ProductsBestSelling(
      allProducts: allProducts,
      salesThreshold: 24,
    ) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| getBestSellingProducts(suggestionCount) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| collection("aux") | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| doc("purchases") | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| collection("items") | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| where("items", arrayContainsAny: userItems) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| get() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| addAll(items.cast<String>() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| removeWhere((id) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| contains(id) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| collection("products") | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| where(FieldPath.documentId, whereIn: relatedItems.toList() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| get() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| map((d) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| fromDocument(d) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| toList() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| where((p) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| any((d) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| toList() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| getBestSellingProducts(24) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| where((p) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| any((d) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| where((p) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| any((s) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| take(needed) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| toList() | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| addAll(bestSellers) | lib/common\advertising\components\purchase_model.dart | common | Função/método em lib/common\advertising\components\purchase_model.dart |
| RecentlyAddedProductsAnimated | lib/common\advertising\components\recently_added_products_animeted.dart | class | Classe presente em lib/common\advertising\components\recently_added_products_animeted.dart |
| _RecentlyAddedProductsAnimatedState | lib/common\advertising\components\recently_added_products_animeted.dart | class | Classe presente em lib/common\advertising\components\recently_added_products_animeted.dart |
| RecentlyAddedProductsAnimated({super.key, required this.products}) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| createState() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| _RecentlyAddedProductsAnimatedState() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| initState() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| initState() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| PageController() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| addPostFrameCallback((_) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| setState(() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| periodic(
      const Duration(seconds: 5) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| _numPages(context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| animateToPage(
          _currentPage,
          duration: const Duration(seconds: 4) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| setState(() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| cancel() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| Timer(
          const Duration(seconds: 2) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| setState(() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| _itemsPerPage(BuildContext context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| of(context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| _numPages(BuildContext context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| _itemsPerPage(context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| ceil() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| dispose() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| dispose() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| cancel() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| cancel() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| dispose() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| build(BuildContext context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: mobileBreakpoint) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| SizedBox(
          height: 150,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _numPages(context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| _itemsPerPage(context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| _itemsPerPage(context) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| clamp(0, widget.products.length) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| sublist(startIndex, endIndex) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| AnimatedOpacity(
                opacity: _fadeIn ? 1.0 : 0.0,
                duration: const Duration(seconds: 2) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: pageProducts.map((product) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| GestureDetector(
                        onTap: () | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| pushNamed(
                            context,
                            RoutesNavigator.productDetailsScreen,
                            arguments: product,
                          ) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| ClipRRect(
                            borderRadius: BorderRadius.circular(12) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| network(
                              product.images!.first,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ) | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| toList() | lib/common\advertising\components\recently_added_products_animeted.dart | common | Função/método em lib/common\advertising\components\recently_added_products_animeted.dart |
| FindsLowestSellingShowcase | lib/common\advertising\finds_lowest_selling_showcase.dart | class | Classe presente em lib/common\advertising\finds_lowest_selling_showcase.dart |
| _FindsItem | lib/common\advertising\finds_lowest_selling_showcase.dart | class | Classe presente em lib/common\advertising\finds_lowest_selling_showcase.dart |
| _FindsItemState | lib/common\advertising\finds_lowest_selling_showcase.dart | class | Classe presente em lib/common\advertising\finds_lowest_selling_showcase.dart |
| FindsLowestSellingShowcase({super.key, this.isSilver = false}) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| build(BuildContext context) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| getLowestSellingProducts(count: 15) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| shrink() | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: tabletBreakpoint) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| textForGoogleDecorations(titleForDecorations: 'Achadinhos especiais pra você') | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| SizedBox(height: 10) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Wrap(
              spacing: 13,
              runSpacing: 13,
              alignment: WrapAlignment.center,
              children: products.map((product) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| of(context) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| SizedBox(
                  width: minWidth.clamp(150, 230) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| _FindsItem(
                    product: product,
                    isSilver: isSilver,
                  ) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| toList() | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| SizedBox(height: 20) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| _FindsItem({
    required this.product,
    this.isSilver = false,
  }) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| createState() | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| _FindsItemState() | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| build(BuildContext context) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| MouseRegion(
      onEnter: (_) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| setState(() | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| setState(() | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(50) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| all(color: borderColor, width: 1.5) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: const Offset(0, 9) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| InkWell(
              borderRadius: BorderRadius.circular(50) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| of(context) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| pushNamed(
                  RoutesNavigator.productDetailsScreen,
                  arguments: widget.product,
                ) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 7,
                          offset: const Offset(5, 0) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(50) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| network(
                        widget.product.images?.first ?? '',
                        width: 90,
                        height: 80,
                        fit: BoxFit.fill,
                        errorBuilder: (_, __, ___) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Container(
                          width: 90,
                          height: 80,
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Icon(Icons.image_not_supported, size: 30) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| SizedBox(width: 8, height: 10) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Expanded(
                    child: AutoSizeText(
                      widget.product.name ?? '',
                      style: Theme.of(context) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| copyWith(
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| SizedBox(width: 7) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| Positioned(
            top: -7,
            right: 15,
            child: TagForCard(
              data: "Somente: ${formattedRealText(widget.product.basePrice) | lib/common\advertising\finds_lowest_selling_showcase.dart | common | Função/método em lib/common\advertising\finds_lowest_selling_showcase.dart |
| CustomFooter | lib/common\advertising\footer.dart | class | Classe presente em lib/common\advertising\footer.dart |
| CustomFooter({super.key, this.isSilver = false}) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| build(BuildContext context) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| debugPrint("Abrindo Comprar...") | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| debugPrint("Abrindo Vender...") | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| debugPrint("Abrindo Facebook...") | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| debugPrint("Abrindo Instagram...") | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| debugPrint("Abrindo YouTube...") | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection(
        "Mais informações",
        [
          "Sobre a Loja: ${currentStore?.nameStore ?? 'BRN'}",
          "Investor relations",
          "Tendências",
          "Sustentabilidade",
        ],
        onTapMap: footerLinks,
      ) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection("Outros sites", ["Desenvolvedores", "Envios", "BRN Info_Dev"]) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection(
        "Contato",
        ["Comprar", "Solução de problemas", "Segurança"],
        onTapMap: footerLinks,
      ) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection("Redes sociais", ["X", "Facebook", "Instagram", "YouTube"],
          onTapMap: footerLinks) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection("Minha conta", ["Minhas compras", "Favoritos", "Lista de desejos"]) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection("Assinaturas",
          ["Meli+", "Disney+", "HBO Max", "Paramount+", "Universal+", "Globoplay Premium"]) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection(
          "Temporadas", ["Dia do consumidor", "Dia das mães", "Black Friday", "descontão"]) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.all(24) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| LayoutBuilder(
        builder: (context, constraints) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.start,
                children: sections
                    .map((s) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SizedBox(
                          width: constraints.maxWidth / crossAxisCount - 32, // distributes width
                          child: s,
                        ) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| toList() | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SizedBox(height: 3) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| Divider(color: Colors.white) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SizedBox(height: 3) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| AutoSizeText(
                wrapWords: true,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                maxFontSize: 12,
                maxLines: 2,
                "Copyright © 2023-2025 - BRN - Informática e Desenvolvimento LTDA.",
                style: TextStyle(color: Colors.white70, fontSize: 12) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SizedBox(height: 3) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| AutoSizeText(
                wrapWords: true,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                maxFontSize: 12,
                maxLines: 3,
                "Fale conosco | Termos e condições | Promoções | "
                "Como cuidamos da sua privacidade | Acessibilidade | "
                "Contato | Informações sobre seguros | Programa de Afiliados | Lista de presentes",
                style: TextStyle(color: Colors.white54, fontSize: 12) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SizedBox(height: 3) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| AutoSizeText(
                wrapWords: true,
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                maxFontSize: 12,
                maxLines: 3,
                "CNPJ n.º 52.129.576/0001-57 / Centro, nº S/N, "
                "Paulo Afonso-BA - CEP 48608-510 - produzido por: BRN Informática e Desenvolvimento.",
                style: TextStyle(color: Colors.white54, fontSize: 12) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SliverToBoxAdapter(child: footerContent) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| _buildSection(String title, List<String> items, {Map<String, VoidCallback>? onTapMap}) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            wrapWords: true,
            overflow: TextOverflow.ellipsis,
            minFontSize: 12,
            maxFontSize: 14,
            maxLines: 2,
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| SizedBox(height: 8) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| Padding(
              padding: const EdgeInsets.only(bottom: 4) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| InkWell(
                onTap: onTapMap != null && onTapMap.containsKey(item) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| AutoSizeText(
                  wrapWords: true,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 12,
                  maxFontSize: 14,
                  maxLines: 2,
                  item,
                  style: TextStyle(
                    color: onTapMap != null && onTapMap.containsKey(item) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| containsKey(item) | lib/common\advertising\footer.dart | common | Função/método em lib/common\advertising\footer.dart |
| HighlightProductsBlock | lib/common\advertising\highlight_products_block.dart | class | Classe presente em lib/common\advertising\highlight_products_block.dart |
| _HighlightProductsBlockState | lib/common\advertising\highlight_products_block.dart | class | Classe presente em lib/common\advertising\highlight_products_block.dart |
| HighlightProductsBlock({
    super.key,
    required this.products,
    this.isSilver = false,
  }) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| createState() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| _HighlightProductsBlockState() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| ScrollController() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| dispose() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| dispose() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| dispose() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| build(BuildContext context) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| shrink() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| LayoutBuilder(
      builder: (context, constraints) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| floor() | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| SizedBox(
          height: 320,
          child: Stack(
            children: [
              ListView.separated(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: spacing) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| SizedBox(width: spacing) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| HighlightProductCard(
                    product: product,
                    onTap: () | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| pushNamed(
                      context,
                      RoutesNavigator.productDetailsScreen,
                      arguments: product,
                    ) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| animateTo(
                        _controller.offset - cardWidth - spacing,
                        duration: const Duration(milliseconds: 300) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| animateTo(
                        _controller.offset + cardWidth + spacing,
                        duration: const Duration(milliseconds: 300) | lib/common\advertising\highlight_products_block.dart | common | Função/método em lib/common\advertising\highlight_products_block.dart |
| InfoMarqueeWidget | lib/common\advertising\info_marquee_widget.dart | class | Classe presente em lib/common\advertising\info_marquee_widget.dart |
| InfoMarqueeWidgetState | lib/common\advertising\info_marquee_widget.dart | class | Classe presente em lib/common\advertising\info_marquee_widget.dart |
| InfoMarqueeWidget({
    super.key,
    required this.text,
    required this.color,
    required this.glowColor,
    required this.marqueeWidth,
    required this.marqueeSpeed,
    required this.marqueeStart,
    required this.marqueeEnd,
    this.marqueeHeight = 30,
    this.borderRadius = 10,
    this.textMaxWidth = 800,
    this.fontSize = 15.0,
    this.fontBorderWidth = 0.4,
    this.fontColor = Colors.black,
    this.fontBorderColor = Colors.transparent,
    this.fontWeight = FontWeight.normal,
    this.onPressed,
  }) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| createState() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| InfoMarqueeWidgetState() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| initState() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| initState() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.marqueeSpeed.toInt() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| repeat(reverse: false) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| Offset(widget.marqueeStart, 0.0) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| Offset(widget.marqueeEnd, 0.0) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| animate(_controller) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| _startGlowAnimation() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| _startGlowAnimation() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| delayed(const Duration(seconds: 2) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| setState(() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| _startGlowAnimation() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| build(BuildContext context) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| Container(
      height: widget.marqueeHeight,
      width: widget.marqueeWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| BoxShadow(
            color: _isGlowing ? widget.glowColor : Colors.transparent,
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(2.8, 2.8) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| Material(
        color: widget.color,
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| Stack(
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 0,
                  ) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| OverflowBox(
                    maxWidth: widget.textMaxWidth,
                    minWidth: widget.textMaxWidth,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: DecoratedGoogleFontText(
                        widget.text,
                        fontMethod: GoogleFonts.roboto,
                        // widget.fontGoogleStyle,
                        fillColor: widget.fontColor,
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        borderWidth: widget.fontBorderWidth,
                        borderColor: widget.fontBorderColor,
                      ) | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| dispose() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| dispose() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| dispose() | lib/common\advertising\info_marquee_widget.dart | common | Função/método em lib/common\advertising\info_marquee_widget.dart |
| PurchaseSuggestionsWidget | lib/common\advertising\purchase_suggestions_widget.dart | class | Classe presente em lib/common\advertising\purchase_suggestions_widget.dart |
| _PurchaseSuggestionsWidgetState | lib/common\advertising\purchase_suggestions_widget.dart | class | Classe presente em lib/common\advertising\purchase_suggestions_widget.dart |
| PurchaseSuggestionsWidget(
      {super.key, this.titleText = 'Quem comprou este produto, também levaram estes...', this.fontSize}) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| createState() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| _PurchaseSuggestionsWidgetState() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| initState() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| initState() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| _loadSuggestions() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| _loadSuggestions() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| setState(() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| getPurchaseSuggestions(
      userId: userId,
      allProducts: allProducts,
      suggestionCount: 24, // maximum PRODUCTS 24
    ) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| setState(() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| getCurrentPageProducts(int perPage) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| sublist(start, end) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| nextPage(int perPage) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| setState(() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| previousPage() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| setState(() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| build(BuildContext context) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Center(child: CircularProgressIndicator() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| shrink() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| of(context) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| getCurrentPageProducts(perPage) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Center(
       child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: tabletBreakpoint) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          textForGoogleDecorations(
              titleForDecorations: widget.titleText, fontSize: widget.fontSize ?? 18, fontWeight: FontWeight.normal) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| SizedBox(height: 12) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Text("${currentPage + 1} / $totalPages") | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| IconButton(
                  icon: const Icon(Icons.arrow_forward) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| nextPage(perPage) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics() | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 400 / 440,
            ) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 80, // max card height
                ) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| InkWell(
                    borderRadius: BorderRadius.circular(16) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| pushNamed(
                        context,
                        RoutesNavigator.productDetailsScreen,
                        arguments: product,
                      ) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Stack(
                      children: [
                        // Background image
                        Positioned.fill(
                          child: Image.network(
                            product.images?.first ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Icon(Icons.image_not_supported, size: 40) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  product.name ?? "Sem nome",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(0.5, 0.5) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| SizedBox(height: 4) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| Text(
                                  'A partir: ${formattedRealText(product.basePrice) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| TextStyle(
                                    fontSize: 12,
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2,
                                        color: Colors.black,
                                        offset: Offset(0.5, 0.5) | lib/common\advertising\purchase_suggestions_widget.dart | common | Função/método em lib/common\advertising\purchase_suggestions_widget.dart |
| class | lib/common\advertising\recently_added_products.dart | class | Classe presente em lib/common\advertising\recently_added_products.dart |
| RecentlyAddedProducts({
    super.key,
    required this.carrossel,
    this.productCategory,
  }) | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| build(BuildContext context) | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| getRecentProducts(
          productCategory: productCategory,
        ) | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| shrink() | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: tabletBreakpoint) | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| SizedBox(
                child: carouselForProducts(
                  context: context,
                  productsForCarousel: recentProducts,
                ) | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| ConstrainedBox(
            constraints: BoxConstraints(maxWidth: mobileBreakpoint) | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| RecentlyAddedProductsAnimated(products: recentProducts) | lib/common\advertising\recently_added_products.dart | common | Função/método em lib/common\advertising\recently_added_products.dart |
| SalesSuggestionVisitedProducts | lib/common\advertising\sales_suggestion_visited_products.dart | class | Classe presente em lib/common\advertising\sales_suggestion_visited_products.dart |
| _SalesSuggestionVisitedProductsState | lib/common\advertising\sales_suggestion_visited_products.dart | class | Classe presente em lib/common\advertising\sales_suggestion_visited_products.dart |
| SalesSuggestionVisitedProducts({super.key}) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| createState() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| _SalesSuggestionVisitedProductsState() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| initState() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| initState() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| ScrollController() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| addPostFrameCallback((_) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| loadSuggestionsBasedOnVisitGalleryProducts(context) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| periodic(const Duration(seconds: 3) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| animateTo(
        nextScroll,
        duration: const Duration(milliseconds: 500) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| dispose() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| cancel() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| dispose() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| dispose() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| scrollLeft() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| clamp(0.0, scrollController.position.maxScrollExtent) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| animateTo(
      newPos,
      duration: const Duration(milliseconds: 400) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| scrollRight() | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| clamp(0.0, scrollController.position.maxScrollExtent) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| animateTo(
      newPos,
      duration: const Duration(milliseconds: 400) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| build(BuildContext context) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| Container(
      width: double.infinity,
      color: Colors.white.withAlpha(792) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textForGoogleDecorations(
            titleForDecorations: 'Você também pode gostar',
            fontSize: 18,
          ) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| SizedBox(
            height: 180,
            child: Stack(
              children: [
                ListView.separated(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 3) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| SizedBox(width: itemSpacing) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| SizedBox(
                      width: itemWidth,
                      child: Card(
                        elevation: 2,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| Stack(
                          children: [
                            Positioned.fill(
                              child: (product.images == null || product.images!.isEmpty) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| asset(
                                      RootAssets.noImagePng,
                                      fit: BoxFit.cover,
                                    ) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| network(
                                      product.images!.first,
                                      fit: BoxFit.cover,
                                    ) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| Positioned(
                              bottom: 5,
                              left: 5,
                              right: 5,
                              child: textForGoogleDecorations(
                                titleForDecorations: product.name ?? 'Nome do Produto',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| pushNamed(
                                      context,
                                      RoutesNavigator.productDetailsScreen,
                                      arguments: product,
                                    ) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| IconButton(
                          icon: const Icon(Icons.arrow_forward_ios) | lib/common\advertising\sales_suggestion_visited_products.dart | common | Função/método em lib/common\advertising\sales_suggestion_visited_products.dart |
| ComplementAppBar | lib/common\app_bar\complement_app_bar.dart | class | Classe presente em lib/common\app_bar\complement_app_bar.dart |
| ComplementAppBar({
    super.key,
    required this.asSliver,
    this.padding, //by default it keeps as sliver
  }) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| _buildContent(BuildContext context) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| Center(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: kIsWeb ? 120 : 85,
          width: tabletBreakpoint,
          decoration: BoxDecoration(
            color: getComplementAppBarCollor() | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| circular(20) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| asset(
                    RootAssets.storeImgLogo,
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      child: AutoSizeText(
                        "Em Construção",
                        minFontSize: 10,
                        maxFontSize: 20,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| SizedBox(width: 9) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| SearchProductsField() | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| SizedBox(width: 3) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| Flexible(
                      child: Container(
                        color: Colors.black,
                        width: 200,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: const AutoSizeText(
                          "Implementar \n Anuncio",
                          maxFontSize: 20,
                          minFontSize: 10,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| build(BuildContext context) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| SliverToBoxAdapter(child: _buildContent(context) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| _buildContent(context) | lib/common\app_bar\complement_app_bar.dart | common | Função/método em lib/common\app_bar\complement_app_bar.dart |
| CustomAppBar | lib/common\app_bar\custom_app_bar.dart | class | Classe presente em lib/common\app_bar\custom_app_bar.dart |
| CustomAppBar({
    super.key,
    required this.title,
    required this.showDrawerIcon,
    required this.showSearchButton,
    this.removePadding,
    this.actions,
    this.elevation = 4.0,
    this.isSilver = false,
    this.backgroundColor,
    this.titleColor,
    this.buttonColor, // default false
  }) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| build(BuildContext context) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Center(
      child: Padding(
        padding: kIsWeb
            ? EdgeInsets.zero
            : (removePadding == true ? EdgeInsets.zero : MediaQuery.of(context) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: wildBreakpoint) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| AppBar(
            elevation: elevation,
            backgroundColor: backgroundColor ?? getCustomAppBarColorBackground() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: tabletBreakpoint) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Row(
                  children: [
                    // Leading (menu/back) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| IconButton(
                        color: buttonColor ?? getCustomAppBarColorIcons() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Icon(Icons.menu) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| of(context) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| openDrawer() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| of(context) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| canPop() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| IconButton(
                        color: buttonColor ?? getCustomAppBarColorIcons() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Icon(Icons.arrow_back) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| of(context) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| maybePop() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| SizedBox(width: 48) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Expanded(
                      child: Center(child: _buildDynamicTitle(context) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showSearchButton) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| _buildSearchButton(context) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| SizedBox(width: 48) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| SliverToBoxAdapter(child: appBarContent) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| TextStyle(
        color: titleColor ?? getCustomAppBarColorTitle() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| _buildDynamicTitle(BuildContext context) | lib/common\app_bar\custom_app_bar.dart | common | Builds dynamic title (regular or based on ProductManager search state) |
| _buildTitle() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| AutoSizeText("Filtro Ativo!", style: _titleTextStyle) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| _buildTitle() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| GestureDetector(
            onTap: () | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| SearchDialog(
                  initialText: productManager.search,
                  hintText: "Pesquise o produto desejado...",
                ) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| AutoSizeText(
              productManager.search,
              maxLines: 1,
              minFontSize: 12,
              maxFontSize: 20,
              textAlign: TextAlign.center,
              style: _titleTextStyle,
            ) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| _buildSearchButton(BuildContext context) | lib/common\app_bar\custom_app_bar.dart | common | Builds the search button (toggles search state) |
| CustomIconButton(
            onTap: () | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| SearchDialog(
                  initialText: productManager.search,
                  hintText: "Pesquise o produto desejado...",
                ) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| getCustomAppBarColorIcons() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| CustomIconButton(
            onTap: () | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| _buildTitle() | lib/common\app_bar\custom_app_bar.dart | common | Builds the fixed title (used when search is inactive) |
| AutoSizeText(
        title as String,
        maxLines: 2,
        minFontSize: 12,
        maxFontSize: 20,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: _titleTextStyle,
      ) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: _titleTextStyle,
          child: title as Widget,
        ) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| shrink() | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| fromHeight(60) | lib/common\app_bar\custom_app_bar.dart | common | Função/método em lib/common\app_bar\custom_app_bar.dart |
| customBottomNavigatorBar({
  required BuildContext context,
  required bool withDrawer,
}) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| SizedBox(
    height: 60,
    child: Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 900) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| circular(20) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| Material(
            elevation: 15,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: getCustomAppBarColorBackground() | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| getCustomAppBarColorIcons() | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| getButtonColor() | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| BottomNavigationBarItem(
                  icon: Icon(Icons.category) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| BottomNavigationBarItem(
                  icon: Icon(Icons.favorite) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| BottomNavigationBarItem(
                  icon: Icon(Icons.home) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.personCircleCheck) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| of(context) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| pop() | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| navigateToPageWithDrawer(
                            context: context,
                            page: DrawerPages.categories,
                          ) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| of(context) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| pushNamed(RoutesNavigator.cartScreen) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| setPage(DrawerPages.favorites) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| navigateToPageWithDrawer(
                            context: context,
                            page: DrawerPages.favorites,
                          ) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| setPage(DrawerPages.home) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| navigateToPageWithDrawer(context: context, page: DrawerPages.home) | lib/common\app_bar\custom_bottom_navigator_bar.dart | common | Função/método em lib/common\app_bar\custom_bottom_navigator_bar.dart |
| CustomButton | lib/common\buttons\custom_button.dart | class | Classe presente em lib/common\buttons\custom_button.dart |
| CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.buttonDisabledColor,
    this.shadowColor = Colors.white24,
    this.elevation = 08,
    this.buttonColor,
    this.heightButton,
    this.widthButton,
  }) | lib/common\buttons\custom_button.dart | common | double.infinity. |
| build(BuildContext context) | lib/common\buttons\custom_button.dart | common | Função/método em lib/common\buttons\custom_button.dart |
| SizedBox(
        height: heightButton ?? 45,
        width: widthButton ?? double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                disabledBackgroundColor: buttonDisabledColor,
                backgroundColor: buttonColor ?? getButtonColor() | lib/common\buttons\custom_button.dart | common | Função/método em lib/common\buttons\custom_button.dart |
| fromLTRB(20, 10, 20, 10) | lib/common\buttons\custom_button.dart | common | Função/método em lib/common\buttons\custom_button.dart |
| RoundedRectangleBorder(borderRadius: BorderRadius.circular(30) | lib/common\buttons\custom_button.dart | common | Função/método em lib/common\buttons\custom_button.dart |
| FittedBox(
                        child: SpinKitThreeInOut(
                          color: getEspecialColor() | lib/common\buttons\custom_button.dart | common | Função/método em lib/common\buttons\custom_button.dart |
| AutoSizeText(
                        overflow: TextOverflow.ellipsis,
                        text,
                        style: TextStyle(color: textColor ?? getTextColor() | lib/common\buttons\custom_button.dart | common | Função/método em lib/common\buttons\custom_button.dart |
| CustomIconButton | lib/common\buttons\custom_icon_button.dart | class | Classe presente em lib/common\buttons\custom_icon_button.dart |
| CustomIconButton({
    super.key,
    required this.iconData,
    required this.semanticLabel,
    required this.onTap,
    this.color,
    this.size,
    this.weight,
    this.padding = const EdgeInsets.fromLTRB(12, 10, 10, 12) | lib/common\buttons\custom_icon_button.dart | common | /// The parameter [padding] sets the internal padding of the buttons. |
| build(BuildContext context) | lib/common\buttons\custom_icon_button.dart | common | Função/método em lib/common\buttons\custom_icon_button.dart |
| ClipRRect(
      borderRadius: BorderRadius.circular(50) | lib/common\buttons\custom_icon_button.dart | common | Função/método em lib/common\buttons\custom_icon_button.dart |
| Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Tooltip(
              message: semanticLabel, // text that appears when hovering over
              child: Icon(
                semanticLabel: semanticLabel, // text for accessibility
                weight: weight,
                size: size,
                iconData,
                color: onTap != null ? color : Colors.grey[400],
              ) | lib/common\buttons\custom_icon_button.dart | common | Função/método em lib/common\buttons\custom_icon_button.dart |
| CustomTextButton | lib/common\buttons\custom_text_button.dart | class | Classe presente em lib/common\buttons\custom_text_button.dart |
| CustomTextButton({
    super.key,
    this.fontColor,
    required this.onPressed,
    this.text,
    this.fontSize = 14,
    this.fontWeight,
    this.icon,
    this.buttonStyle,
    this.imageAssetsTarget,
    this.imageWidth = 28,
    this.imageHeight = 28,
    this.isSvg = false,
    this.imageColor,
  }) | lib/common\buttons\custom_text_button.dart | common | /// The parameter [imageColor] sets the color of the image displayed on the button. |
| build(BuildContext context) | lib/common\buttons\custom_text_button.dart | common | Função/método em lib/common\buttons\custom_text_button.dart |
| TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: text == null && icon != null
          ? icon!
          : FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? icon!
                      : imageAssetsTarget != null
                          ? isSvg! // Checks if the image is of SVG type
                              ? SvgPicture.asset(
                                  imageAssetsTarget!,
                                  width: imageWidth,
                                  height: imageHeight,
                                ) | lib/common\buttons\custom_text_button.dart | common | Função/método em lib/common\buttons\custom_text_button.dart |
| asset(
                                  imageAssetsTarget!,
                                  width: imageWidth,
                                  height: imageHeight,
                                  color: imageColor,
                                ) | lib/common\buttons\custom_text_button.dart | common | Função/método em lib/common\buttons\custom_text_button.dart |
| SizedBox(height: 20) | lib/common\buttons\custom_text_button.dart | common | Função/método em lib/common\buttons\custom_text_button.dart |
| SizedBox(width: 10) | lib/common\buttons\custom_text_button.dart | common | Função/método em lib/common\buttons\custom_text_button.dart |
| Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    text ?? '',
                    style: TextStyle(
                      color: fontColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ) | lib/common\buttons\custom_text_button.dart | common | Função/método em lib/common\buttons\custom_text_button.dart |
| CustomTextButtonStyles | lib/common\buttons\custom_text_button_styles.dart | class | Classe presente em lib/common\buttons\custom_text_button_styles.dart |
| ButtonStyle(
    shadowColor: WidgetStateProperty.all<Color>(Colors.black) | lib/common\buttons\custom_text_button_styles.dart | common | Função/método em lib/common\buttons\custom_text_button_styles.dart |
| fromARGB(255, 24, 118, 241) | lib/common\buttons\custom_text_button_styles.dart | common | Função/método em lib/common\buttons\custom_text_button_styles.dart |
| RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30) | lib/common\buttons\custom_text_button_styles.dart | common | Função/método em lib/common\buttons\custom_text_button_styles.dart |
| ButtonStyle(
    shadowColor: WidgetStateProperty.all<Color>(Colors.black) | lib/common\buttons\custom_text_button_styles.dart | common | Função/método em lib/common\buttons\custom_text_button_styles.dart |
| RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30) | lib/common\buttons\custom_text_button_styles.dart | common | Função/método em lib/common\buttons\custom_text_button_styles.dart |
| FlexibleProductCard | lib/common\cards\flexible_product_card.dart | class | Classe presente em lib/common\cards\flexible_product_card.dart |
| FlexibleProductCard({
    super.key,
    required this.product,
    required this.isVertical,
    this.onTap,
  }) | lib/common\cards\flexible_product_card.dart | common | Creates a flexible product card. |
| build(BuildContext context) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| of(context) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| getTextColorBasedOnBackground(backgroundColor) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| UserManager() | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| GestureDetector(
      onTap: onTap ??
          () | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| pushNamed(context, RoutesNavigator.editProductScreen, arguments: product) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| pushNamed(context, RoutesNavigator.productDetailsScreen,
                    arguments: product) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Card(
                  semanticContainer: true,
                  color: primaryColor,
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Padding(
                    padding: const EdgeInsets.only(bottom: 4) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Column(
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxHeight: 185) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: imageNotAvailable
                                    ? Image.asset(
                                        RootAssets.noImagePng,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: 250,
                                      ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Image(
                                        image: NetworkImage(
                                          product?.images?.first ?? "",
                                        ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| FreightLogo(
                                product: product ?? Product() | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| circular(9) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Positioned(
                                bottom: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| TagForCard(
                                    data: !product!.hasStock
                                        ? 'Estoque\n Esgotado!'
                                        : 'A partir:\n '
                                            '${formattedRealText(product!.basePrice) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| withAlpha(90) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| FavoritesWidget(
                                product: product!,
                              ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Container(
                          constraints: const BoxConstraints(maxHeight: 120) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| fromLTRB(9, 5, 9, 5) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 17,
                                  maxLines: 2,
                                  minFontSize: 12,
                                  product?.name ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.bold, color: textColor) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 17,
                                  maxLines: 3,
                                  minFontSize: 10,
                                  product?.description ?? '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15, color: textColor) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Align(
                                alignment: Alignment.center,
                                child: AutoSizeText(
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 15,
                                  maxLines: 1,
                                  minFontSize: 10,
                                  product?.brand != "" ? 'Marca: ${product!.brand}' : ' ',
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w600, color: textColor) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAlias,
                  elevation: 7,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Container(
                    constraints: const BoxConstraints(maxHeight: 145, minWidth: 100) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Row(
                      children: [
                        // Product Image
                        AspectRatio(
                          aspectRatio: 1,
                          child: imageNotAvailable
                              ? Image.asset(RootAssets.noImagePng, fit: BoxFit.fitHeight) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| network(product?.images?.first ?? "", fit: BoxFit.cover) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| ListView(
                              children: [
                                // Product name + favorite
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        product!.name!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800,
                                        ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| FavoritesWidget(product: product ?? Product() | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| AutoSizeText(
                                  product?.description ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| AutoSizeText(
                                    'Marca: ${product?.brand ?? ''}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                    ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Row(
                                  children: [
                                    product!.hasStock
                                        ? Text(
                                            'A partir de: ',
                                            style:
                                                TextStyle(fontSize: 15.0, color: Colors.grey[600]) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Text(
                                            'Aguardando reposição de estoque...',
                                            style:
                                                TextStyle(fontSize: 14.0, color: Colors.grey[600]) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| SizedBox(width: 5) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Text(
                                            formattedRealText(basePrice) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Text(
                                            'Fora de estoque',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ) | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| Container() | lib/common\cards\flexible_product_card.dart | common | Função/método em lib/common\cards\flexible_product_card.dart |
| LoginCard | lib/common\cards\login_card.dart | class | Classe presente em lib/common\cards\login_card.dart |
| LoginCard({super.key}) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| build(BuildContext context) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| of(context) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 260, maxWidth: 380) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Card(
          elevation: 20,
          margin: const EdgeInsets.all(16) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.account_circle,
                  color: primaryColor,
                  size: 100,
                ) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Padding(
                  padding: const EdgeInsets.all(0.8) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Text(
                    'Você precisa estar logado.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| SizedBox(height: 16) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Entrar',
                        onPressed: () | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| pushNamed(
                            context,
                            RoutesNavigator.loginScreen,
                          ) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| SizedBox(width: 12) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| Expanded(
                      child: CustomButton(
                        text: 'Depois',
                        onPressed: () | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| setPage(DrawerPages.home) | lib/common\cards\login_card.dart | common | Função/método em lib/common\cards\login_card.dart |
| PriceCard | lib/common\cards\price_card.dart | class | Classe presente em lib/common\cards\price_card.dart |
| PriceCard({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.showIcon,
  }) | lib/common\cards\price_card.dart | common | /// The parameter [onPressed] is a function called when the button is pressed. |
| build(BuildContext context) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: mobileBreakpoint) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 16) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: showIcon == false ? false : true,
                      child: CustomIconButton(
                          iconData: Icons.add_shopping_cart_rounded,
                          padding: EdgeInsets.zero,
                          semanticLabel: 'Voltar \n ao carrinho',
                          onTap: () | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| pushReplacementNamed(context, RoutesNavigator.cartScreen) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Text(
                  'Resumo do pedido:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| SizedBox(height: 12) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(child: Text('Total de ítens:') | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Expanded(
                      child: Text(
                        totalItens.toString() | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| TextStyle(fontSize: 12, fontWeight: FontWeight.w800) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Divider() | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Subtotal:',
                      ) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Expanded(
                      child: Text(
                        formattedRealText(productsPrice) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Divider() | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(child: Text('Envio:') | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Expanded(
                        child: Text(
                          formattedRealText(deliveryPrice) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Divider() | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text('Envio:') | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Expanded(
                        child: Text(
                          'Frete Grátis',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                            fontSize: 14,
                          ) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Divider() | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| SizedBox(height: 12) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text(
                        'Total:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| Expanded(
                      child: Text(
                        formattedRealText(totalPrice) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| TextStyle(color: Theme.of(context) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| SizedBox(height: 8) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| CustomButton(
                  text: buttonText,
                  onPressed: onPressed,
                  widthButton: 350,
                ) | lib/common\cards\price_card.dart | common | Função/método em lib/common\cards\price_card.dart |
| CustomDrawerHeader | lib/common\drawer\components\drawer_header.dart | class | Classe presente em lib/common\drawer\components\drawer_header.dart |
| CustomDrawerHeader({super.key}) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| build(BuildContext context) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 8) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const AutoSizeText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    minFontSize: 10,
                    maxFontSize: 20,
                    'Loja Virtual:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| InkWell(
                      child: Image.asset(
                        RootAssets.storeImgLogo,
                        height: 90,
                        fit: BoxFit.scaleDown,
                      ) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| setPage(DrawerPages.home) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| AutoSizeText(
                    'Bem-Vindo(a) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| TextStyle(fontSize: 20, fontWeight: FontWeight.bold) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| SizedBox(height: 5) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| GestureDetector(
                    onTap: () | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| signOut(context) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| setPage(DrawerPages.home) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| pushNamed(context, RoutesNavigator.loginScreen) | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: 16,
                      userManager.isLoggedIn ? 'Sair' : 'Entre ou Cadastre-se >',
                      style: TextStyle(
                          color: getEspecialColor() | lib/common\drawer\components\drawer_header.dart | common | Função/método em lib/common\drawer\components\drawer_header.dart |
| DrawerPageView | lib/common\drawer\components\drawer_page_view.dart | class | Classe presente em lib/common\drawer\components\drawer_page_view.dart |
| DrawerPageView({super.key}) | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| build(BuildContext context) | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| addPostFrameCallback((_) | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| jumpToPage(
          pageManager.currentPage.index,
        ) | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| PageView(
      controller: pageManager.pageController,
      physics: const NeverScrollableScrollPhysics() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| HomeScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| CategoriesScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| OrdersScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| FavoritesScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| WishList() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| StoresScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| WhoWeArePage() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| AdminUsersScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| AdminOrdersScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| ProductsScreen() | lib/common\drawer\components\drawer_page_view.dart | common | Função/método em lib/common\drawer\components\drawer_page_view.dart |
| DrawerTitle | lib/common\drawer\components\drawer_title.dart | class | Classe presente em lib/common\drawer\components\drawer_title.dart |
| DrawerTitle({super.key, this.iconData, this.title, this.page}) | lib/common\drawer\components\drawer_title.dart | common | Função/método em lib/common\drawer\components\drawer_title.dart |
| build(BuildContext context) | lib/common\drawer\components\drawer_title.dart | common | Função/método em lib/common\drawer\components\drawer_title.dart |
| InkWell(
          onTap: () | lib/common\drawer\components\drawer_title.dart | common | Função/método em lib/common\drawer\components\drawer_title.dart |
| setPage(page!) | lib/common\drawer\components\drawer_title.dart | common | Função/método em lib/common\drawer\components\drawer_title.dart |
| SizedBox(
            height: 60,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32) | lib/common\drawer\components\drawer_title.dart | common | Função/método em lib/common\drawer\components\drawer_title.dart |
| Icon(
                    iconData!,
                    size: 32,
                    color: pageManager.currentPage == page ? getEspecialColor() | lib/common\drawer\components\drawer_title.dart | common | Função/método em lib/common\drawer\components\drawer_title.dart |
| Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    title!,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          pageManager.currentPage == page ? getEspecialColor() | lib/common\drawer\components\drawer_title.dart | common | Função/método em lib/common\drawer\components\drawer_title.dart |
| PageManager | lib/common\drawer\components\page_manager.dart | class | Classe presente em lib/common\drawer\components\page_manager.dart |
| PageManager() | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| PageController(initialPage: 0) | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| setPage(DrawerPages page) | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| _getPageIndex(page) | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| jumpToPage(pageIndex) | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| addPostFrameCallback((_) | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| jumpToPage(pageIndex) | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| notifyListeners() | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| _getPageIndex(DrawerPages page) | lib/common\drawer\components\page_manager.dart | common | Função/método em lib/common\drawer\components\page_manager.dart |
| SettingsDrawer | lib/common\drawer\components\setting_drawer.dart | class | Classe presente em lib/common\drawer\components\setting_drawer.dart |
| SettingsDrawer({super.key}) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| build(BuildContext context) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| Text(
            'Gerenciar Categorias',
          ) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| Text('Configurações gerais') | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| Text('Mapeamento Estrutural') | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| setPage(DrawerPages.categories) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| of(context) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| pushNamed(RoutesNavigator.mapeamentoView) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| Icon(
                Icons.settings,
                size: 33,
              ) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| SizedBox(width: 4) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| Flexible(
              fit: FlexFit.loose,
              child: Text(
                'Configurações:',
                style: TextStyle(
                  fontSize: 16,
                ) | lib/common\drawer\components\setting_drawer.dart | common | Função/método em lib/common\drawer\components\setting_drawer.dart |
| CustomDrawer | lib/common\drawer\custom_drawer.dart | class | Classe presente em lib/common\drawer\custom_drawer.dart |
| CustomDrawer({super.key}) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| build(BuildContext context) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| LayoutBuilder(
      builder: (context, constraints) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| ConstrainedBox(
          constraints: constraints.maxWidth <= 600
              ? BoxConstraints(maxWidth: MediaQuery.of(context) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| BoxConstraints(maxWidth: MediaQuery.of(context) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 5, 10) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Drawer(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          getDrawerColorFirst() | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| getDrawerColorSecond() | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| ListView(
                    children: [
                      const CustomDrawerHeader() | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Divider() | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                        iconData: Icons.home,
                        title: "Início",
                        page: DrawerPages.home,
                      ) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Divider(thickness: 2) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Text(
                        'P R O D U T O S:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                        iconData: Icons.list_alt_sharp,
                        title: "Por Categorias",
                        page: DrawerPages.categories,
                      ) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Divider(thickness: 2) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Text(
                        'SEÇÕES DO CLIENTE:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                          iconData: Icons.playlist_add_check,
                          title: "Meus pedidos",
                          page: DrawerPages.orders) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                          iconData: Icons.favorite,
                          title: "Meus favoritos",
                          page: DrawerPages.favorites) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                        iconData: FontAwesomeIcons.heartPulse,
                        title: "Meus de desejos",
                        page: DrawerPages.wishlist,
                      ) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Divider(thickness: 2) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                        iconData: Icons.location_on,
                        title: "Lojas",
                        page: DrawerPages.stores,
                      ) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                          iconData: FontAwesomeIcons.peopleGroup,
                          title: "Quem Somos?",
                          page: DrawerPages.whoWeAre) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Column(
                              children: [
                                const Divider(thickness: 3) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Text(
                                  'ÁREA ADMINISTRATIVA:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                                    iconData: Icons.supervised_user_circle,
                                    title: 'Clientes',
                                    page: DrawerPages.adminUsers) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                                    iconData: Icons.task_alt,
                                    title: 'Pedidos',
                                    page: DrawerPages.adminOrders) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| DrawerTitle(
                                    iconData: Icons.list,
                                    title: "Listar todos",
                                    page: DrawerPages.products) | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| SettingsDrawer() | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| Container() | lib/common\drawer\custom_drawer.dart | common | Função/método em lib/common\drawer\custom_drawer.dart |
| includes | lib/common\formatted_fields\custom_text_form_field.dart | class | Classe presente em lib/common\formatted_fields\custom_text_form_field.dart |
| CustomTextFormField | lib/common\formatted_fields\custom_text_form_field.dart | class | Classe presente em lib/common\formatted_fields\custom_text_form_field.dart |
| d(
///   title: 'Name',
///   hintText: 'Enter your name',
///   initialValue: 'Bruno Salgado',
///   onChanged: (value) | lib/common\formatted_fields\custom_text_form_field.dart | common | CustomTextFormFiel |
| Function(String?) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| Function(String?) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| Function(String?) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| Function(String?) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| CustomTextFormField({
    super.key,
    this.onSaved,
    this.hintText,
    this.title,
    this.titleBold = false,
    this.textInputType = TextInputType.text,
    this.focusedBorder,
    this.focusedBorderColor,
    this.fillColor = Colors.transparent,
    this.enabledBorder,
    this.hintColor,
    this.isDense = true,
    this.contentPadding,
    this.filled,
    this.titleColor = Colors.white,
    this.titleSize = 10,
    this.hintSize = 14,
    this.textFormFieldBold = false,
    this.hintBold = false,
    this.validator,
    this.initialValue,
    this.inputFormatters,
    this.labelText,
    this.textFormFieldSize = 16,
    this.textFormFieldColor = Colors.black,
    this.obscureText = false,
    this.enableBorderColor,
    this.enableTextEdit,
    this.textCapitalization,
    this.maxLength,
    this.controller,
    this.onChanged,
    this.autocorrect,
    this.prefixText,
    this.counterText = '',
    this.textAlign = TextAlign.start,
    this.focusNode,
    this.onSubmitted,
  }) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| build(BuildContext context) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? Container() | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| Text(
                title ?? '',
                style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: titleBold ? FontWeight.bold : FontWeight.w400,
                    color: titleColor) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| TextFormField(
          initialValue: initialValue,
          inputFormatters: inputFormatters,
          enabled: enableTextEdit,
          controller: controller,
          autocorrect: autocorrect ?? true,
          focusNode: focusNode,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          maxLength: maxLength,
          textAlign: textAlign!,
          style: TextStyle(
            color: textFormFieldColor,
            fontWeight: textFormFieldBold ? FontWeight.bold : FontWeight.w400,
            fontSize: textFormFieldSize,
          ) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixText: prefixText,
            counterText: counterText,
            hintStyle: TextStyle(
              color: hintColor ?? Colors.black.withAlpha(100) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| BorderSide(
                    color: focusedBorderColor ?? getFocusBorderColor() | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| BorderSide(
                    color: enableBorderColor ?? Colors.black87,
                  ) | lib/common\formatted_fields\custom_text_form_field.dart | common | Função/método em lib/common\formatted_fields\custom_text_form_field.dart |
| formatTimestamp(Timestamp timestamp) | lib/common\formatted_fields\format_timestamp.dart | common | ## formatTimestamp |
| toDate() | lib/common\formatted_fields\format_timestamp.dart | common | Função/método em lib/common\formatted_fields\format_timestamp.dart |
| DateFormat("dd/MM/yyyy HH:mm") | lib/common\formatted_fields\format_timestamp.dart | common | Função/método em lib/common\formatted_fields\format_timestamp.dart |
| format(dateTime) | lib/common\formatted_fields\format_timestamp.dart | common | Função/método em lib/common\formatted_fields\format_timestamp.dart |
| formattedZipcode(String? address) | lib/common\formatted_fields\format_values.dart | common | - Returns the formatted zip code or '00000000' if the address is null or does not have 8 characters. |
| unFormattedZipcode(address) | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| obterCep(address!) | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| unFormattedZipcode(String? address) | lib/common\formatted_fields\format_values.dart | common | - Returns the unformatted zip code. |
| replaceAll(RegExp(r"[^0-9]") | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| formattedPhoneNumber(String? phone) | lib/common\formatted_fields\format_values.dart | common | - Returns the formatted phone number. |
| obterTelefone(phone ?? "") | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| unFormatPhone(String formattedValue) | lib/common\formatted_fields\format_values.dart | common | - Returns the unformatted phone number. |
| replaceAll(RegExp(r"[^\d]") | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| formattedRealText(num real) | lib/common\formatted_fields\format_values.dart | common | - Returns the value formatted as Brazilian currency. |
| obterReal(real.toDouble() | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| formattedRealTextFormFiled(num real) | lib/common\formatted_fields\format_values.dart | common | - Returns the value formatted as text. |
| obterReal(real.toDouble() | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| unFormattedReal(String formattedValue) | lib/common\formatted_fields\format_values.dart | common | - Returns the unformatted value. |
| replaceAll(".", "") | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| replaceAll(",", ".") | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| formattedOrderId(String? orderId) | lib/common\formatted_fields\format_values.dart | common | - Returns the formatted order ID. |
| padLeft(6, "0") | lib/common\formatted_fields\format_values.dart | common | Função/método em lib/common\formatted_fields\format_values.dart |
| TimeInputFormatter | lib/common\formatted_fields\time_input_formatter.dart | class | Classe presente em lib/common\formatted_fields\time_input_formatter.dart |
| formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| _formatTime(newValue.text) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| copyWith(
      text: formattedValue,
      selection: _updateCursorPosition(formattedValue, newValue.selection) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| _formatTime(String value) | lib/common\formatted_fields\time_input_formatter.dart | common | /// Takes a [value] as input and returns the formatted time string. |
| replaceAll(RegExp(r'\D') | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| substring(0, 2) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| substring(2) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| substring(0, 2) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| substring(2, 4) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| substring(4, 6) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| substring(6, 8) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| _updateCursorPosition(String value, TextSelection oldSelection) | lib/common\formatted_fields\time_input_formatter.dart | common | /// Takes the formatted [value] and [oldSelection] as input and returns the updated cursor position. |
| collapsed(offset: newPosition) | lib/common\formatted_fields\time_input_formatter.dart | common | Função/método em lib/common\formatted_fields\time_input_formatter.dart |
| getColorFromString(String color) | lib/common\functions\common_functions.dart | common | If the input string is not in the correct format, returns Colors.transparent. |
| parse(color.substring(1, 7) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Color(value) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| withAlpha(255) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| getHexColor(Color color) | lib/common\functions\common_functions.dart | common | /// Takes a [color] object and returns the corresponding hexadecimal color string. |
| toRadixString(16) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| padLeft(8, '0') | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| substring(2) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| toUpperCase() | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| sendEmailNotification({
  required String recipientEmail, // Recipient email as parameter
  required String subject, // Subject as parameter
  required String messageText, // Message as a parameter
}) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| gmail('suporte@brninfodev.com', 'sua-senha') | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Message() | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Address('seu-email@gmail.com', 'Seu Nome') | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| add(recipientEmail) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| send(message, smtpServer) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| debugPrint('Mensagem enviada: ${sendReport.toString() | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| debugPrint('Erro ao enviar e-mail: $error') | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| reportNoFatalErrorToCrashlytics(
    {required String error,
    String? reason,
    required StackTrace stackTrace,
    required String information}) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| recordError(
    error,
    stackTrace,
    reason: reason ?? 'Monitoramento Try-Catch',
    information: [information, 'version 1.0'],
  ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| customProgressIndicator(
    {Color? color,
    double? strokeWidth,
    Color? stopAnimationColor,
    Color? linearBackgroundColor,
    required bool isCircular,
    required bool isLoading}) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Center(
      child: CircularProgressIndicator(
        color: color ?? Colors.blue,
        strokeWidth: strokeWidth ?? 6,
        valueColor: AlwaysStoppedAnimation(stopAnimationColor ?? Colors.blue) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color ?? Colors.blue) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| shrink() | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| navigateToPageWithDrawer({
  required BuildContext context,
  required DrawerPages page,
}) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| popAndPushNamed(context, RoutesNavigator.homeScreen) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| addPostFrameCallback((_) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| setPage(page) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| carouselForProducts({
  required BuildContext context,
  required List<Product> productsForCarousel,
}) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| CarouselSliderControllerImpl() | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| of(context) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| CarouselSlider(
    carouselController: carouselController,
    options: CarouselOptions(
      aspectRatio: 1 / 1,
      initialPage: 0,
      height: height,
      viewportFraction: viewportFraction,
      disableCenter: disableCenter,
      enlargeCenterPage: true,
      enlargeFactor: enlargeFactor,
      enableInfiniteScroll: true,
      scrollDirection: Axis.horizontal,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 4) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Duration(milliseconds: 800) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Stack(
          fit: StackFit.expand,
          children: [
            // Transparent Diffuse Background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| circular(30) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      product.images!.first,
                      fit: BoxFit.fill,
                    ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Container(
                        color: Colors.white.withAlpha(50) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Center(
              child: Material(
                elevation: 7,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| circular(30) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| circular(30) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: height - 12, // ensures that it never exceeds the bottom
                      maxWidth: screenWidth * viewportFraction, //respect the card
                    ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| network(
                      product.images!.first,
                      fit: BoxFit.fitHeight,
                    ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Padding(
              padding: const EdgeInsets.all(10) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| TagForCard(
                data: 'A partir:\n ${formattedRealText(product.basePrice) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Positioned(
              bottom: 10,
              right: 10,
              child: Material(
                color: Theme.of(context) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| withAlpha(90) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| IconButton(
                  icon: const Icon(
                    Icons.open_in_new,
                    semanticLabel: 'Visualizar Produto',
                    size: 30,
                  ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| pushNamed(
                      context,
                      RoutesNavigator.productDetailsScreen,
                      arguments: product,
                    ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| toList() | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| textForGoogleDecorations(
    {required String titleForDecorations,
    double? fontSize,
    double? borderWidth,
    dynamic fontMethod,
    dynamic fontWeight,
    Color? fillColor,
    Color? borderColor}) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Padding(
    padding: const EdgeInsets.fromLTRB(8, 1, 8, 0) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| DecoratedGoogleFontText(
      titleForDecorations,
      fontMethod: fontMethod ?? GoogleFonts.bungeeSpice,
      fillColor: fillColor ?? Colors.transparent,
      borderColor: borderColor ?? Colors.transparent,
      fontSize: fontSize ?? 22,
      fontWeight: fontWeight ?? FontWeight.w800,
      borderWidth: borderWidth ?? 0.8,
    ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| buildCategoryImage({required ProductCategory productCategory}) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| file(img, fit: BoxFit.cover) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| network(
        img,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Center(
            child: CircularProgressIndicator(strokeWidth: 2) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| Container(
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: const Icon(Icons.broken_image, size: 30, color: Colors.grey) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| asset(
    RootAssets.imageForEmptyBackgroundsJpg,
    fit: BoxFit.cover,
  ) | lib/common\functions\common_functions.dart | common | Função/método em lib/common\functions\common_functions.dart |
| provides | lib/common\messengers\custom_alertdialog_adaptive.dart | class | Classe presente em lib/common\messengers\custom_alertdialog_adaptive.dart |
| CustomAlertDialogAdaptive | lib/common\messengers\custom_alertdialog_adaptive.dart | class | Classe presente em lib/common\messengers\custom_alertdialog_adaptive.dart |
| CustomAlertDialogAdaptive({
    required this.titleText,
    required this.bodyText,
    required this.actions,
    this.content,
    this.titleColor = Colors.red,
    this.titleSize = 22,
    this.titleWeight = FontWeight.w400,
    this.bodyColor = Colors.black,
    this.bodySize = 14,
    this.bodyWeight = FontWeight.w600,
    this.titleAlign = TextAlign.center,
    this.bodyAlign = TextAlign.center,
    this.contentPadding,
  }) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | /// The parameter [contentPadding] sets the padding for the content area of the alert dialog. |
| adaptiveAction(
      {required BuildContext context, required VoidCallback onPressed, required Widget child}) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | Função/método em lib/common\messengers\custom_alertdialog_adaptive.dart |
| of(context) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | Função/método em lib/common\messengers\custom_alertdialog_adaptive.dart |
| TextButton(onPressed: onPressed, child: child) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | Função/método em lib/common\messengers\custom_alertdialog_adaptive.dart |
| CupertinoDialogAction(onPressed: onPressed, child: child) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | Função/método em lib/common\messengers\custom_alertdialog_adaptive.dart |
| alertContent(BuildContext context) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | /// Shows an adaptive alert dialog using [showAdaptiveDialog] with an [AlertDialog.adaptive]. |
| adaptive(
        title: Text(
          titleText ?? '',
          style: TextStyle(
            color: titleColor,
            fontWeight: titleWeight,
            fontSize: titleSize,
          ) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | Função/método em lib/common\messengers\custom_alertdialog_adaptive.dart |
| Text(bodyText ?? '',
                style: TextStyle(
                  color: bodyColor,
                  fontWeight: bodyWeight,
                  fontSize: bodySize,
                ) | lib/common\messengers\custom_alertdialog_adaptive.dart | common | Função/método em lib/common\messengers\custom_alertdialog_adaptive.dart |
| CustomScaffoldMessenger | lib/common\messengers\custom_scaffold_messenger.dart | class | Classe presente em lib/common\messengers\custom_scaffold_messenger.dart |
| CustomScaffoldMessenger({
    required this.context,
    required this.message,
    this.backgroundColor = Colors.red,
    this.duration = const Duration(seconds: 8) | lib/common\messengers\custom_scaffold_messenger.dart | common | /// The parameter [iconColor] sets the color of the icon in the Snackbar. |
| TextStyle(fontSize: 18) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| alertScaffold() | lib/common\messengers\custom_scaffold_messenger.dart | common | /// This method checks if the message is not empty and then shows a Snackbar using ScaffoldMessenger. |
| of(context) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| showSnackBar(
        SnackBar(
          width: MediaQuery.of(context) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| Padding(
            padding: const EdgeInsets.all(4.0) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| Row(
              children: [
                Icon(Icons.error_outline_outlined, color: iconColor, size: 34) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| SizedBox(width: 7) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| Flexible(
                  child: Text(
                    message,
                    style: textStyle,
                  ) | lib/common\messengers\custom_scaffold_messenger.dart | common | Função/método em lib/common\messengers\custom_scaffold_messenger.dart |
| for | lib/common\miscellaneous\communications_utils.dart | class | Classe presente em lib/common\miscellaneous\communications_utils.dart |
| that | lib/common\miscellaneous\communications_utils.dart | class | Classe presente em lib/common\miscellaneous\communications_utils.dart |
| is | lib/common\miscellaneous\communications_utils.dart | class | Classe presente em lib/common\miscellaneous\communications_utils.dart |
| CommunicationsUtils | lib/common\miscellaneous\communications_utils.dart | class | Classe presente em lib/common\miscellaneous\communications_utils.dart |
| CommunicationsUtils({
    required this.parameterClass1Of2,
    this.parameterClass2Of2,
    this.hasError,
  }) | lib/common\miscellaneous\communications_utils.dart | common | /// The [hasError] parameter indicates if an error has occurred, defaulting to `false`. |
| alertForCall(BuildContext context, String message) | lib/common\miscellaneous\communications_utils.dart | common | /// The [message] parameter is the message to be displayed in the alert. |
| CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertScaffold() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertForEmail(BuildContext context, String message) | lib/common\miscellaneous\communications_utils.dart | common | /// The [message] parameter is the message to be displayed in the alert. |
| CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertScaffold() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| sendEmail(String? userEmail, String? userName, List<String>? emails) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| encodeQueryParameters(Map<String, String> params) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| map((MapEntry<String, String> e) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| encodeComponent(e.key) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| encodeComponent(e.value) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| join("&") | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| Uri(
        scheme: "mailto",
        path: userEmail ?? emails.toString() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| replaceAll(RegExp(r"[\[\]]") | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| encodeQueryParameters(<String, String>{
          "subject": AlertsMessengersText.subjectOfTheEmail,
          "body": userName == null
              ? AlertsMessengersText.bodyMessangersEmailWithowtUserName
              : "$userName,\n ${AlertsMessengersText.bodyMessangersEmailWithUserName}",
        }) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| launchUrl(emailLaunchUri) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertForMaps(BuildContext context, String message) | lib/common\miscellaneous\communications_utils.dart | common | message and duration will be displayed. |
| CustomScaffoldMessenger(
        context: context,
        message: message,
        duration: const Duration(seconds: 10) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertScaffold() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| openMap(
      BuildContext context, double lat, double long, String title, String description) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| closeModal() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| pop(context) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| showModalContext() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| showModalBottomSheet(
        context: showModalContext() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final map in availableMap) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| ListTile(
                    onTap: () | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| showMarker(
                        coords: Coords(lat, long) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| closeModal() | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| Text(map.mapName) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| asset(
                      map.icon,
                      width: 30,
                      height: 30,
                    ) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertForMaps(context, '') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| openPhone(BuildContext context, String phoneNumber) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertForCall(context, 'Número telefônico indisponível!') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| unFormatPhone('+55$phoneNumber') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| canLaunchUrl(Uri.parse('tel:$webPhoneNumber') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| launchUrl(Uri.parse('tel:$webPhoneNumber') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| canLaunchUrl(Uri.parse('tel:$phoneNumber') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| launchUrl(Uri.parse('tel:$phoneNumber') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertForCall(context, '') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| openEmail(BuildContext context, String emailAddress) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| Uri(
        scheme: 'mailto',
        path: emailAddress,
      ) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| canLaunchUrl(emailLaunchUri) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| launchUrl(emailLaunchUri) | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| alertForEmail(context, '') | lib/common\miscellaneous\communications_utils.dart | common | Função/método em lib/common\miscellaneous\communications_utils.dart |
| EmptyPageIndicator | lib/common\miscellaneous\empty_page_indicator.dart | class | Classe presente em lib/common\miscellaneous\empty_page_indicator.dart |
| for | lib/common\miscellaneous\empty_page_indicator.dart | class | Classe presente em lib/common\miscellaneous\empty_page_indicator.dart |
| EmptyPageIndicatorState | lib/common\miscellaneous\empty_page_indicator.dart | class | Classe presente em lib/common\miscellaneous\empty_page_indicator.dart |
| EmptyPageIndicator({
    super.key,
    required this.title,
    required this.iconData,
    required this.image,
    this.duration = const Duration(seconds: 17) | lib/common\miscellaneous\empty_page_indicator.dart | common | /// The [titleColor] parameter sets the color of the title text. |
| createState() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| EmptyPageIndicatorState() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| initState() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| initState() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| delayed(widget.duration!, () | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| setState(() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| build(BuildContext context) | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| Padding(
      padding: const EdgeInsets.all(16) | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: _showFirst,
            child: Column(
              children: [
                widget.image == null
                    ? Container() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| asset(
                        widget.image!,
                        width: 180,
                        height: 180,
                      ) | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| Container() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| Icon(
                        widget.iconData,
                        size: widget.iconSize ?? 80.0,
                        color: widget.iconColor ?? getCustomAppBarColorIcons() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| SizedBox(height: 16) | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: widget.iconSize ?? 20,
                    fontWeight: FontWeight.bold,
                    color: widget.titleColor ?? getTextColor() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| Visibility(
            visible: !_showFirst,
            child: Column(
              children: [
                Icon(
                  Icons.wifi_sharp,
                  size: widget.iconSize ?? 100.0,
                  color: widget.iconColor ?? getCustomAppBarColorIcons() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| Text(
                  AlertsMessengersText.erroEmptyPageIndicator,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.titleColor ?? getTextColor() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| dispose() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| cancel() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| dispose() | lib/common\miscellaneous\empty_page_indicator.dart | common | Função/método em lib/common\miscellaneous\empty_page_indicator.dart |
| FreightLogo | lib/common\miscellaneous\freight_logo.dart | class | Classe presente em lib/common\miscellaneous\freight_logo.dart |
| FreightLogo({
    super.key,
    required this.product,
    this.positionedBottom = 0,
    this.positionedRight,
    this.positionedTop,
    this.positionedLeft,
    this.containerHeight = 35,
    this.fontSize = 12,
    this.iconSize = 23,
    this.text = "Frete Gratis",
    this.containerWidth,
    this.radiusTopLeft,
    this.radiusTopRight,
    this.radiusBottomRight,
    this.radiusBottomLeft,
  }) | lib/common\miscellaneous\freight_logo.dart | common | /// The [text] parameter sets the text to be displayed inside the logo. |
| build(BuildContext context) | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| Positioned(
        bottom: positionedBottom,
        right: positionedRight,
        left: positionedLeft,
        top: positionedTop,
        child: Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
            color: const Color.fromARGB(247, 151, 250, 194) | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| only(
              topLeft: radiusTopLeft ?? const Radius.circular(9) | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| all(5) | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| CustomTextButton(
            buttonStyle: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(2) | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| TextStyle(fontSize: fontSize) | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| Icon(
              FontAwesomeIcons.truckFast,
              opticalSize: iconSize,
            ) | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| Container() | lib/common\miscellaneous\freight_logo.dart | common | Função/método em lib/common\miscellaneous\freight_logo.dart |
| TagForCard | lib/common\miscellaneous\tag_for_cards.dart | class | Classe presente em lib/common\miscellaneous\tag_for_cards.dart |
| TagForCard({
    super.key,
    required this.data,
    required this.alignment,
    required this.backgroundColor,
    this.containerWidth = 130,
    this.containerHeight,
    this.alphaBackgroundColor = 90,
    this.textFontSize,
    this.googleFonts = GoogleFonts.rancho,
  }) | lib/common\miscellaneous\tag_for_cards.dart | common | /// The [googleFonts] parameter sets the Google Font style for the tag text. |
| build(BuildContext context) | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| getTextColorBasedOnBackground(backgroundColor) | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| getBorderColorInvertedTextColor(backgroundColor) | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| Align(
      alignment: alignment,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          color: backgroundColor.withAlpha(alphaBackgroundColor ?? 90) | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| only(
            topLeft: Radius.circular(9.0) | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| circular(9.0) | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| all(7) | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| FittedBox(
          fit: BoxFit.scaleDown,
          child: DecoratedGoogleFontText(
            data.toString() | lib/common\miscellaneous\tag_for_cards.dart | common | Função/método em lib/common\miscellaneous\tag_for_cards.dart |
| CustomLoadingOverlay | lib/common\Progress_indicators\custom_loading_overlay.dart | class | Classe presente em lib/common\Progress_indicators\custom_loading_overlay.dart |
| CustomLoadingOverlay({
    super.key,
    this.message = 'Carregando...',
  }) | lib/common\Progress_indicators\custom_loading_overlay.dart | common | Função/método em lib/common\Progress_indicators\custom_loading_overlay.dart |
| build(BuildContext context) | lib/common\Progress_indicators\custom_loading_overlay.dart | common | Função/método em lib/common\Progress_indicators\custom_loading_overlay.dart |
| fill(
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white) | lib/common\Progress_indicators\custom_loading_overlay.dart | common | Função/método em lib/common\Progress_indicators\custom_loading_overlay.dart |
| SizedBox(height: 16) | lib/common\Progress_indicators\custom_loading_overlay.dart | common | Função/método em lib/common\Progress_indicators\custom_loading_overlay.dart |
| Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ) | lib/common\Progress_indicators\custom_loading_overlay.dart | common | Função/método em lib/common\Progress_indicators\custom_loading_overlay.dart |
| CustomProgressButton | lib/common\Progress_indicators\custom_progress_button.dart | class | Classe presente em lib/common\Progress_indicators\custom_progress_button.dart |
| _CustomProgressButtonState | lib/common\Progress_indicators\custom_progress_button.dart | class | Classe presente em lib/common\Progress_indicators\custom_progress_button.dart |
| CustomProgressButton({
    super.key,
    this.height = 48,
    this.width = double.infinity,
  }) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| createState() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| _CustomProgressButtonState() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| initState() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| initState() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| AnimationController(
      duration: const Duration(seconds: 2) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| repeat() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| animate(_animationController) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| dispose() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| dispose() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| dispose() | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| build(BuildContext context) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| SizedBox(
      height: widget.height,
      width: widget.width,
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| BoxShadow(
                  color: Colors.green.withOpacity(0.6) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.green.withOpacity(0.6) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| withOpacity(0.9) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| clamp(0.0, 1.0) | lib/common\Progress_indicators\custom_progress_button.dart | common | Função/método em lib/common\Progress_indicators\custom_progress_button.dart |
| SearchDialog | lib/common\search\components\search_dialog.dart | class | Classe presente em lib/common\search\components\search_dialog.dart |
| SearchDialog({super.key, required this.initialText, required this.hintText}) | lib/common\search\components\search_dialog.dart | common | /// The [hintText] parameter is the hint text displayed in the search field when it's empty. |
| build(BuildContext context) | lib/common\search\components\search_dialog.dart | common | Função/método em lib/common\search\components\search_dialog.dart |
| Stack(
      children: [
        Positioned(
          top: 2,
          left: 5,
          right: 5,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15) | lib/common\search\components\search_dialog.dart | common | Função/método em lib/common\search\components\search_dialog.dart |
| IconButton(
                  icon: const Icon(Icons.arrow_back) | lib/common\search\components\search_dialog.dart | common | Função/método em lib/common\search\components\search_dialog.dart |
| of(context) | lib/common\search\components\search_dialog.dart | common | Função/método em lib/common\search\components\search_dialog.dart |
| pop() | lib/common\search\components\search_dialog.dart | common | Função/método em lib/common\search\components\search_dialog.dart |
| of(context) | lib/common\search\components\search_dialog.dart | common | Função/método em lib/common\search\components\search_dialog.dart |
| pop(text) | lib/common\search\components\search_dialog.dart | common | Função/método em lib/common\search\components\search_dialog.dart |
| searchProductsOverlay({
  required BuildContext context,
  required List<Product> products,
  required String query,
  required VoidCallback clearSearch, // clears the search field
}) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| remove() | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| where((p) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| toLowerCase() | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| contains(query.toLowerCase() | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| toList() | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| of(context) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| closeOverlay(VoidCallback? clearSearch, OverlayEntry overlayEntry) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| remove() | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| call() | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| OverlayEntry(
    builder: (context) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 600, maxWidth: tabletBreakpoint) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| BoxDecoration(
                  color: Colors.black.withAlpha(90) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| circular(20) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| BoxShadow(blurRadius: 10, color: Colors.black26) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| ClipRRect(
                  borderRadius: BorderRadius.circular(20) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| Center(
                          child: Padding(
                            padding: EdgeInsets.all(16) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| EmptyPageIndicator(
                              title: 'Nenhum produto encontrado...',
                              iconData: Icons.search_off,
                              image: null,
                            ) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| builder(
                          padding: const EdgeInsets.all(8) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 260,
                            mainAxisExtent: 318,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| FlexibleProductCard(
                              product: product,
                              isVertical: true,
                              onTap: () | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| closeOverlay(clearSearch, overlayEntry) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| pushNamed(
                                  context,
                                  RoutesNavigator.productDetailsScreen,
                                  arguments: product,
                                ) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| closeOverlay(clearSearch, overlayEntry) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| all(6) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| Icon(Icons.close, size: 25, color: Colors.black87) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| insert(overlayEntry) | lib/common\search\components\search_products_overlay.dart | common | Função/método em lib/common\search\components\search_products_overlay.dart |
| showSearchOverlay(BuildContext context, String query, VoidCallback clearSearch) | lib/common\search\components\show_search_overlay.dart | common | Função/método em lib/common\search\components\show_search_overlay.dart |
| searchProductsOverlay(
    context: context,
    products: productManager.allProducts,
    query: query,
    clearSearch: () | lib/common\search\components\show_search_overlay.dart | common | Função/método em lib/common\search\components\show_search_overlay.dart |
| clearSearch() | lib/common\search\components\show_search_overlay.dart | common | Função/método em lib/common\search\components\show_search_overlay.dart |
| SearchClients | lib/common\search\search_clients.dart | class | Classe presente em lib/common\search\search_clients.dart |
| searchClientsTextAppBar({required BuildContext context}) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| Text(
            'Clientes',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| GestureDetector(
            onTap: () | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| SearchDialog(
                  initialText: adminUsersSearch.search,
                  hintText: 'Pesquisar Cliente',
                ) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| Container(
              color: const Color.fromARGB(16, 255, 255, 255) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| Text(
                adminUsersSearch.search,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| actionsSearchClients({required BuildContext context}) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| IconButton(
            onPressed: () | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| SearchDialog(
                  initialText: adminUsersSearch.search,
                  hintText: 'Pesquisar Cliente',
                ) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| Icon(Icons.search) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| IconButton(
            onPressed: () | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| filterList(adminUsersSearch.allUsers) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| Icon(Icons.close) | lib/common\search\search_clients.dart | common | Função/método em lib/common\search\search_clients.dart |
| SearchProductsField | lib/common\search\search_products_field.dart | class | Classe presente em lib/common\search\search_products_field.dart |
| _SearchProductsFieldState | lib/common\search\search_products_field.dart | class | Classe presente em lib/common\search\search_products_field.dart |
| SearchBox | lib/common\search\search_products_field.dart | class | Classe presente em lib/common\search\search_products_field.dart |
| SearchProductsField({super.key}) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| createState() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| _SearchProductsFieldState() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| TextEditingController() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| _toggleOverlay(BuildContext context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| remove() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| setState(() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| _createOverlay(context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| of(context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| insert(_overlayEntry!) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| setState(() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| _createOverlay(BuildContext context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| OverlayEntry(
      builder: (context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| Positioned(
        top: 50, // below the AppBar
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| BoxShadow(blurRadius: 8, color: Colors.black26) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    autofocus: true,
                    onChanged: (query) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| showSearchOverlay(context, query, () | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| clear() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| InputDecoration(
                      hintText: 'Buscar produtos...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| IconButton(
                  icon: const Icon(Icons.arrow_forward_ios) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| showSearchOverlay(context, _controller.text, () | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| clear() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| IconButton(
                  icon: const Icon(Icons.close) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| remove() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| clear() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| setState(() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| build(BuildContext context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| of(context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| Flexible(
        fit: FlexFit.loose,
        child: SearchBox(
          controller: _controller,
          autofocus: false,
          onSearch: (query) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| showSearchOverlay(context, query, () | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| clear() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| IconButton(
      icon: const Icon(Icons.search, color: Colors.grey) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| _toggleOverlay(context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| SearchBox({
    super.key,
    required this.controller,
    this.hintText = "Buscar produtos...",
    this.onSearch,
    this.autofocus = false,
  }) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| build(BuildContext context) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| submit() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| trim() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| call(q) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| clear() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        onSubmitted: (_) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| submit() | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| TextStyle(fontSize: 18, fontWeight: FontWeight.w500) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search, color: Colors.grey) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| SizedBox(
            width: 88,
            child: FittedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Buscar',
                    icon: const Icon(Icons.search) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| IconButton(
                    tooltip: 'Ir',
                    icon: const Icon(Icons.arrow_forward_ios) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| OutlineInputBorder(
            borderRadius: BorderRadius.circular(30) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| withAlpha(90) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| symmetric(horizontal: 16) | lib/common\search\search_products_field.dart | common | Função/método em lib/common\search\search_products_field.dart |
| PanelController() | lib/common\sliding_up_panel\components\controller.dart | common | Função/método em lib/common\sliding_up_panel\components\controller.dart |
| r(s) | lib/common\sliding_up_panel\components\filters_result.dart | common | the name of the active filte |
| filtersResult() | lib/common\sliding_up_panel\components\filters_result.dart | common | /// Returns a widget that contains the active filter(s) name and a clear button. |
| Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 20, 5) | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Filtro(s) | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| Ativo(s) | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.redAccent,
            ) | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| Text(
            productManager.selectedFiltersByUser.length > 1
                ? 'Múltiplos Filtros'
                : productManager.activeFilterName ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ) | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| IconButton(
            icon: const Icon(
              Icons.close,
              size: 20,
              color: Colors.red,
            ) | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| disableFilter() | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| close() | lib/common\sliding_up_panel\components\filters_result.dart | common | Função/método em lib/common\sliding_up_panel\components\filters_result.dart |
| SlidingFiltersProducts | lib/common\sliding_up_panel\components\sliding_filters_products.dart | class | Classe presente em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| SlidingFiltersProductsState | lib/common\sliding_up_panel\components\sliding_filters_products.dart | class | Classe presente em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| SlidingFiltersProducts({
    super.key,
    required this.selectedStatus,
  }) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| createState() | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| SlidingFiltersProductsState() | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| build(BuildContext context) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| of(context) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: StatusOfProducts.values.map((s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| contains(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| adaptive(
              title: Text(ProductManager.getStatusText(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| setState(() | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| contains(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| remove(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| add(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| remove(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| clear() | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| setStatusFilter(
                      status: s,
                      enabled: widget.selectedStatus.contains(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| clear() | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| remove(s) | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| debugPrint(productManager.filtersOn.toString() | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| toList() | lib/common\sliding_up_panel\components\sliding_filters_products.dart | common | Função/método em lib/common\sliding_up_panel\components\sliding_filters_products.dart |
| customSlidingUpPainel({
  required Widget? body,
  required BuildContext context,
  required Widget? childrenOfPainel,
  required Color? slidingTitleColor,
  required String? textOfSlidingUpPanel,
  List<BoxShadow>? boxShadow,
  double? borderRadiosBottomLeft,
  double? borderRadiosBottomRight,
  double? borderRadiosTopLeft,
  double? borderRadiosTopRight,
}) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| SlidingUpPanel(
    controller: ControlsSlidingPanel.panelController,
    boxShadow: boxShadow ??
        const [
          BoxShadow(
            blurRadius: 2.8,
            color: Color.fromRGBO(0, 0, 0, 20) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| only(
      bottomLeft: Radius.circular(borderRadiosBottomLeft ?? 10) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| circular(borderRadiosBottomRight ?? 10) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| circular(borderRadiosTopLeft ?? 0) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| circular(borderRadiosTopRight ?? 0) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| of(context) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: mobileBreakpoint) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| open() | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| close() | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| Container(
                height: 40,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  textOfSlidingUpPanel ?? 'F I L T R O S',
                  style: TextStyle(
                    color: slidingTitleColor ?? Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ) | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| Container() | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| Container() | lib/common\sliding_up_panel\custom_sliding_up_painel.dart | common | Função/método em lib/common\sliding_up_panel\custom_sliding_up_painel.dart |
| responsible | lib/models\admin_area\admin_orders_manager.dart | class | Classe presente em lib/models\admin_area\admin_orders_manager.dart |
| handles | lib/models\admin_area\admin_orders_manager.dart | class | Classe presente em lib/models\admin_area\admin_orders_manager.dart |
| AdminOrdersManager | lib/models\admin_area\admin_orders_manager.dart | class | Classe presente em lib/models\admin_area\admin_orders_manager.dart |
| toList() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| where((o) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| toList() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| where((o) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| contains(o.status) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| toList() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| _listenToOrders() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| MonitoringLogger() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| logInfo('_listenToOrders') | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| PerformanceMonitoring() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| startTrace('listen-orders', shouldStart: true) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| collection("orders") | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| snapshots() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| listen((events) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| add(OrderClient.fromDocument(change.doc) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| firstWhere((element) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| updateFromDocument(change.doc) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| notifyListeners() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| PerformanceMonitoring() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| stopTrace('listen-orders') | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| updateAdmin({required bool adminEnable}) | lib/models\admin_area\admin_orders_manager.dart | common | If adminEnable is true, listens to orders from Firestore. |
| clear() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| cancel() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| _listenToOrders() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| setUserFilter(Users? user) | lib/models\admin_area\admin_orders_manager.dart | common | Sets the user filter for orders. |
| notifyListeners() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| setStatusFilter({StatusOfOrders? status, bool? enabled}) | lib/models\admin_area\admin_orders_manager.dart | common | The [enabled] parameter specifies whether to add or remove the status filter. |
| add(status!) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| notifyListeners() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| remove(status) | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| notifyListeners() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| dispose() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| cancel() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| dispose() | lib/models\admin_area\admin_orders_manager.dart | common | Função/método em lib/models\admin_area\admin_orders_manager.dart |
| responsible | lib/models\admin_area\admin_users_manager.dart | class | Classe presente em lib/models\admin_area\admin_users_manager.dart |
| handles | lib/models\admin_area\admin_users_manager.dart | class | Classe presente em lib/models\admin_area\admin_users_manager.dart |
| AdminUsersManager | lib/models\admin_area\admin_users_manager.dart | class | Classe presente em lib/models\admin_area\admin_users_manager.dart |
| _listenToUsers() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| PerformanceMonitoring() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| startTrace('listen-users', shouldStart: true) | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| MonitoringLogger() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| logInfo('Info message: Instance  _listenToUsers') | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| collection("users") | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| get(const GetOptions(source: Source.cache) | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| map((d) | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| fromDocument(d) | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| toList() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| notifyListeners() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| collection("users") | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| snapshots() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| listen((snapshot) | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| map((d) | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| fromDocument(d) | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| toList() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| notifyListeners() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| PerformanceMonitoring() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| stopTrace('listen-users') | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| updateUser(UserManager userManager) | lib/models\admin_area\admin_users_manager.dart | common | If adminEnable is false, clears the user list. |
| _listenToUsers() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| clear() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| notifyListeners() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| dispose() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| cancel() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| dispose() | lib/models\admin_area\admin_users_manager.dart | common | Função/método em lib/models\admin_area\admin_users_manager.dart |
| AdminUsersSearch | lib/models\admin_area\admin_users_search.dart | class | Classe presente em lib/models\admin_area\admin_users_search.dart |
| map((e) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| toList() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| unmodifiable(_favouriteUsers) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| unmodifiable(_normalUsers) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| map((u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _buildUserTile(u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| toList() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| map((u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _buildUserTile(u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| toList() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| search(String value) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| setUsers(allUsers) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| notifyListeners() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| setUsers(List<Users> users) | lib/models\admin_area\admin_users_search.dart | common | AUpdates all users and populates the lists |
| trim() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| where((u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| toLowerCase() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| contains(_search.toLowerCase() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| toList() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| filterList(current) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| filterList(List<Users> users) | lib/models\admin_area\admin_users_search.dart | common | Create favorite and normal lists |
| clear() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| addAll(users.where((u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| clear() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| addAll(users.where((u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| clear() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| addAll(users.map((e) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| notifyListeners() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _buildUserTile(Users user) | lib/models\admin_area\admin_users_search.dart | common | Build dinâmico do Tile |
| Slidable(
      key: ValueKey(user.id) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| ActionPane(
        motion: const DrawerMotion() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| SlidableAction(
            label: isFav ? 'Desfavoritar' : 'Favorito',
            backgroundColor: isFav ? Colors.red : Colors.green,
            icon: Icons.star,
            onPressed: (_) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _disfavoringUser(user.id) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _favoringUser(user.id) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| ActionPane(
        motion: const DrawerMotion() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| SlidableAction(
              label: 'Enviar',
              backgroundColor: Colors.cyanAccent,
              icon: Icons.email,
              onPressed: (context) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _showEmailDialog(context, user) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| SlidableAction(
            label: kIsWeb ? 'WhatsApp' : 'Ligar',
            backgroundColor: Colors.greenAccent,
            icon: kIsWeb ? FontAwesomeIcons.whatsapp : Icons.phone,
            onPressed: (context) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| CommunicationsUtils(parameterClass1Of2: user) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| openPhone(context, user.phoneNumber ?? '') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| CommunicationsUtils(parameterClass1Of2: user) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| alertForCall(context, 'Erro ao tentar abrir o telefone!') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| ListTile(
            leading: SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: (user.userPhotoURL == null || user.userPhotoURL!.isEmpty) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| CircleAvatar(
                            backgroundImage: AssetImage(RootAssets.iconUserNoImage) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| CircleAvatar(
                            backgroundImage: NetworkImage(user.userPhotoURL!) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| Positioned(
                      right: -4,
                      top: -4,
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 25,
                      ) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| Text(
              user.userName ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: isFav ? getEspecialColor() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| getTextColor() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| Text(
              "${user.email}\nTel.: ${user.phoneNumber ?? ""}",
              style: TextStyle(
                fontSize: 16,
                color: isFav ? getEspecialColor() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| getTextColor() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| setUserFilter(user) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| setPage(DrawerPages.adminOrders) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _showEmailDialog(BuildContext context, Users user) | lib/models\admin_area\admin_users_search.dart | common | Email sending dialog |
| showDialog(
      context: context,
      builder: (dialogContext) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| AlertDialog(
        title: const Text('Atenção') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| Text('Deseja enviar o email para todos os contatos?') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| TextButton(
            onPressed: () | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| CommunicationsUtils(parameterClass1Of2: user) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| sendEmail(null, null, allEmails) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| of(dialogContext) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| pop() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| Text('Sim') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| TextButton(
            onPressed: () | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| CommunicationsUtils(parameterClass1Of2: user) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| sendEmail(user.email, user.userName, email) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| of(dialogContext) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| pop() | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| Text('Não') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _favoringUser(String? userId) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| collection('users') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| doc(userId) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| update({'favourite': true}) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| debugPrint('Erro ao favoritar: $e') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| indexWhere((u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| setUsers(allUsers) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| _disfavoringUser(String? userId) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| collection('users') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| doc(userId) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| update({'favourite': false}) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| debugPrint('Erro ao desfavoritar: $e') | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| indexWhere((u) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| setUsers(allUsers) | lib/models\admin_area\admin_users_search.dart | common | Função/método em lib/models\admin_area\admin_users_search.dart |
| ExportAddressDialog | lib/models\admin_area\components\export_address_dialog.dart | class | Classe presente em lib/models\admin_area\components\export_address_dialog.dart |
| ScreenshotController() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| ExportAddressDialog({
    required this.address,
    required this.orderClient,
  }) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| alertForShowAddress(BuildContext context) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| CustomAlertDialogAdaptive(
      titleText: 'Endereço de Entrega',
      titleSize: 19,
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(8) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| Text(
              'Pedido: ${formattedOrderId(orderId) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| formattedZipcode(address?.zipCode) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| fromLTRB(16, 16, 16, 0) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| CustomTextButton(
          text: 'Exportar',
          fontColor: Theme.of(context) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| of(context) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| pop() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| capture() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| asUint8List() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| Blob([bytes]) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| createObjectUrlFromBlob(blob) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| AnchorElement(href: url) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| setAttribute("download", "${formattedOrderId(orderId) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| click() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| revokeObjectUrl(url) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| AnchorElement(href: url) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| setAttribute("download", "${formattedOrderId(orderId) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| append(downloadLink) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| capture() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| then((value) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| getApplicationDocumentsDirectory() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| File('${dir.path}/${formattedOrderId(orderId) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| create() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| writeAsBytes(image!) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| saveFile(imagePath.path) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| CustomScaffoldMessenger(
                    // ignore: use_build_context_synchronously
                    context: context,
                    message: 'Endereço salvo no dispositivo',
                    duration: const Duration(seconds: 5) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| alertScaffold() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| CustomScaffoldMessenger(
                    // ignore: use_build_context_synchronously
                    context: context,
                    message: 'Erro ao salvar o endereço na galeria.',
                    duration: const Duration(seconds: 5) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| alertScaffold() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| catchError((error) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| CustomScaffoldMessenger(
                    context: context,
                    message:
                        'Erro: "$error" ao tentar exportar o endereço, favor tentar novamente.',
                    duration: const Duration(seconds: 5) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| alertScaffold() | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| alertContent(context) | lib/models\admin_area\components\export_address_dialog.dart | common | Função/método em lib/models\admin_area\components\export_address_dialog.dart |
| AdminAssetsController | lib/models\admin_area\configs\admin_images_controller.dart | class | Classe presente em lib/models\admin_area\configs\admin_images_controller.dart |
| assetExists(String assetPath) | lib/models\admin_area\configs\admin_images_controller.dart | common | Função/método em lib/models\admin_area\configs\admin_images_controller.dart |
| load(assetPath) | lib/models\admin_area\configs\admin_images_controller.dart | common | Função/método em lib/models\admin_area\configs\admin_images_controller.dart |
| AdminAssetsController() | lib/models\admin_area\configs\admin_images_controller.dart | common | Função/método em lib/models\admin_area\configs\admin_images_controller.dart |
| storeLogo() | lib/models\admin_area\configs\admin_images_controller.dart | common | Função/método em lib/models\admin_area\configs\admin_images_controller.dart |
| assetExists(storeAssetsLogo) | lib/models\admin_area\configs\admin_images_controller.dart | common | Função/método em lib/models\admin_area\configs\admin_images_controller.dart |
| asset(
//                 "assets/logo/storeLogo.png",
//                 width: 15,
//                 height: 15,
//             ) | lib/models\admin_area\configs\admin_images_controller.dart | common | Função/método em lib/models\admin_area\configs\admin_images_controller.dart |
| AutoSizeText(
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//                 minFontSize: 10,
//                 maxFontSize: 34,
//                 'Loja Virtual:\n BRN Info_Dev',
//                 style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold) | lib/models\admin_area\configs\admin_images_controller.dart | common | Função/método em lib/models\admin_area\configs\admin_images_controller.dart |
| AdminMessagesController | lib/models\admin_area\configs\admin_messages_controller.dart | class | Classe presente em lib/models\admin_area\configs\admin_messages_controller.dart |
| AdvertisingManager | lib/models\advertising\advertising_manager.dart | class | Classe presente em lib/models\advertising\advertising_manager.dart |
| AdvertisingManager({
//     required this.allProducts,
//     this.cardContents = const [],
//     this.imageContents = const [],
//   }) | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| initializeContents() | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| clear() | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| clear() | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| map((product) | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| AdvertisingCarouselContent(
//       type: ContentType.productCard,
//       product: product,
//     ) | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| toList() | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| add('url_da_imagem_1') | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| add('url_da_imagem_2') | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| map((imageUrl) | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| AdvertisingCarouselContent(
//       type: ContentType.image16x9,
//       imageUrl: imageUrl,
//     ) | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| toList() | lib/models\advertising\advertising_manager.dart | common | Função/método em lib/models\advertising\advertising_manager.dart |
| FavoritesManager | lib/models\favorites\favorites_manager.dart | class | Classe presente em lib/models\favorites\favorites_manager.dart |
| unmodifiable(_favoritos) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| unmodifiable(_wishlist) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| FavoritesManager({required this.userManager}) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| updateUser(userManager.users!.id) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| addListener(() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| updateUser(userManager.users?.id) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| updateUser(String? userId) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| clear() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| clear() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| collection('users') | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| doc(userId) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| get() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| data() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| from(data['favorites'] ?? []) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| from(data['wishlist'] ?? []) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| addAll(
      favoriteIds.map(
        (id) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| collection('products') | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| doc(id) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| get() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| any((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| add(Product.fromDocument(pDoc) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| addAll(
      wishlistIds.map(
        (id) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| collection('products') | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| doc(id) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| get() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| any((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| add(Product.fromDocument(pDoc) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| wait(futures) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| notifyListeners() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| isFavorite(Product product) | lib/models\favorites\favorites_manager.dart | getter | Função/método em lib/models\favorites\favorites_manager.dart |
| any((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| addFavorite(Product product) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| isFavorite(product) | lib/models\favorites\favorites_manager.dart | getter | Função/método em lib/models\favorites\favorites_manager.dart |
| add(product) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| notifyListeners() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| _updateFirestore() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| removeFavorite(Product product) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| removeWhere((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| notifyListeners() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| _updateFirestore() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| isInWishlist(Product product) | lib/models\favorites\favorites_manager.dart | getter | Função/método em lib/models\favorites\favorites_manager.dart |
| any((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| addWishlist(Product product) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| isInWishlist(product) | lib/models\favorites\favorites_manager.dart | getter | Função/método em lib/models\favorites\favorites_manager.dart |
| add(product) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| notifyListeners() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| _updateFirestore() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| removeWishlist(Product product) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| removeWhere((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| notifyListeners() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| _updateFirestore() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| _updateFirestore() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| collection('users') | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| doc(userId) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| update(
      {
        'favorites': _favoritos.map((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| toSet() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| toList() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| map((p) | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| toSet() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| toList() | lib/models\favorites\favorites_manager.dart | common | Função/método em lib/models\favorites\favorites_manager.dart |
| responsible | lib/models\home_sections\home_manager.dart | class | Classe presente em lib/models\home_sections\home_manager.dart |
| handles | lib/models\home_sections\home_manager.dart | class | Classe presente em lib/models\home_sections\home_manager.dart |
| HomeManager | lib/models\home_sections\home_manager.dart | class | Classe presente em lib/models\home_sections\home_manager.dart |
| HomeManager() | lib/models\home_sections\home_manager.dart | common | Initializes a [HomeManager] instance and loads home page home_sections. |
| _loadSections() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _loadSections() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| PerformanceMonitoring() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| startTrace('load-home_sections', shouldStart: true) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| MonitoringLogger() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| logInfo('Starting listen Sections') | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| collection("home") | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| orderBy("position") | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| snapshots() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| listen((snapshot) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| clear() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| add(Section.fromDocument(doc) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _ensureLocalBestSellingSection() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _ensureLocalRecentlyAddedSection() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| PerformanceMonitoring() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| stopTrace('load-home_sections') | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| MonitoringLogger() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| logInfo('Ending listen Sections') | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _ensureLocalBestSellingSection() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| any((s) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| indexWhere((s) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| insert(
        indexToInsert >= 0 ? indexToInsert + 1 : 0,
        Section(type: 'BestSelling', name: 'Mais Vendidos') | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _ensureLocalRecentlyAddedSection() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| any((s) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| indexWhere((s) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| insert(
        indexToInsert >= 0 ? indexToInsert + 4 : 0,
        Section(type: 'RecentlyAdded', name: 'Adicionados Recentemente') | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| addSection(Section section) | lib/models\home_sections\home_manager.dart | common | Adds a new section to the list of editing home_sections. |
| add(section) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| removeSection(Section section) | lib/models\home_sections\home_manager.dart | common | Removes a section from the list of editing home_sections. |
| remove(section) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| moveSectionUp(Section section) | lib/models\home_sections\home_manager.dart | common | Moves a section up in the list of editing home_sections. |
| indexOf(section) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _swapSections(section, _editingSections[idx - 1]) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| moveSectionDown(Section section) | lib/models\home_sections\home_manager.dart | common | Moves a section down in the list of editing home_sections. |
| indexOf(section) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _swapSections(section, _editingSections[idx + 1]) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| _swapSections(Section s1, Section s2) | lib/models\home_sections\home_manager.dart | common | Swaps the positions of two home_sections in the list of editing home_sections. |
| indexOf(s1) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| indexOf(s2) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| enterEditing() | lib/models\home_sections\home_manager.dart | common | Enters editing mode by cloning current home_sections for editing. |
| map((s) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| clone() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| toList() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| saveEditing() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| valid() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| saveSection(position) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| from(_sections) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| any((e) | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| delete() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| discardEditing() | lib/models\home_sections\home_manager.dart | common | Discards changes made in editing mode. |
| clear() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| notifyListeners() | lib/models\home_sections\home_manager.dart | common | Função/método em lib/models\home_sections\home_manager.dart |
| representing | lib/models\home_sections\section.dart | class | Classe presente em lib/models\home_sections\section.dart |
| represents | lib/models\home_sections\section.dart | class | Classe presente em lib/models\home_sections\section.dart |
| Section | lib/models\home_sections\section.dart | class | Classe presente em lib/models\home_sections\section.dart |
| Section({this.id, this.name, this.type, this.items, this.position}) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| from(items!) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| fromDocument(DocumentSnapshot document) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| map((i) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| fromMap(i as Map<String, dynamic>) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| toList() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| from(items!) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| doc("home/$id") | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| ref() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| child("home") | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| child(id!) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| error(String? value) | lib/models\home_sections\section.dart | common | Setter for error message |
| notifyListeners() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| addItem(SectionItem item) | lib/models\home_sections\section.dart | common | Add an item to the section |
| add(item) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| notifyListeners() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| removeItem(SectionItem item) | lib/models\home_sections\section.dart | common | to remove an item from the section |
| remove(item) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| notifyListeners() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| saveSection(int position) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| PerformanceMonitoring() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| startTrace('save-section', shouldStart: true) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| collection("home") | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| add(data) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| update(data) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| split(',') | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| replaceAll(RegExp("[^$validCharacters]") | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| decode(trimmedString) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| fromList(bytes) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| SettableMetadata(contentType: "image/jpeg") | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| child(const Uuid() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| v4() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| putData(uint8ListBytes, metadata) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| whenComplete(() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| getDownloadURL() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| print('Erro ao decodificar base64String: $e') | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| child(const Uuid() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| v4() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| putFile(item.image as File) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| whenComplete(() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| getDownloadURL() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| contains(original) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| contains("firebase") | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| refFromURL(original.image as String) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| delete() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| MonitoringLogger() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| logError('Erro ao Salvar Seção: $error') | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| map((e) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| toMap() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| toList() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| update(itemsData) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| PerformanceMonitoring() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| stopTrace('save-section') | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| delete() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| delete() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| contains("firebase") | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| refFromURL(item.image as String) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| delete() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| valid() | lib/models\home_sections\section.dart | bool | Validation now ignores BestSelling section |
| clone() | lib/models\home_sections\section.dart | common | Method to clone the section |
| Section(
      id: id,
      name: name,
      type: type,
      position: position,
      items: items?.map((e) | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| clone() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| toList() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| toString() | lib/models\home_sections\section.dart | common | Função/método em lib/models\home_sections\section.dart |
| representing | lib/models\home_sections\section_item.dart | class | Classe presente em lib/models\home_sections\section_item.dart |
| SectionItem | lib/models\home_sections\section_item.dart | class | Classe presente em lib/models\home_sections\section_item.dart |
| SectionItem({this.image, this.product}) | lib/models\home_sections\section_item.dart | common | [product] is the name or description of the item. |
| fromMap(Map<String, dynamic> map) | lib/models\home_sections\section_item.dart | common | Função/método em lib/models\home_sections\section_item.dart |
| toMap() | lib/models\home_sections\section_item.dart | common | Função/método em lib/models\home_sections\section_item.dart |
| clone() | lib/models\home_sections\section_item.dart | common | /// Returns a new SectionItem object with the same image and product values. |
| SectionItem(image: image, product: product) | lib/models\home_sections\section_item.dart | common | Função/método em lib/models\home_sections\section_item.dart |
| toString() | lib/models\home_sections\section_item.dart | common | Função/método em lib/models\home_sections\section_item.dart |
| includes | lib/models\locations_services\address.dart | class | Classe presente em lib/models\locations_services\address.dart |
| Address | lib/models\locations_services\address.dart | class | Classe presente em lib/models\locations_services\address.dart |
| Address(
      {this.street,
      this.number,
      this.complement,
      this.district,
      this.zipCode,
      this.city,
      this.state,
      this.lat,
      this.long}) | lib/models\locations_services\address.dart | common | Creates an [Address] object with the specified parameters. |
| fromMap(Map<String, dynamic> map) | lib/models\locations_services\address.dart | common | Função/método em lib/models\locations_services\address.dart |
| toMap() | lib/models\locations_services\address.dart | common | Função/método em lib/models\locations_services\address.dart |
| unFormattedZipcode(zipCode ?? "00000000") | lib/models\locations_services\address.dart | common | Função/método em lib/models\locations_services\address.dart |
| provides | lib/models\locations_services\cepaberto_map_api.dart | class | Classe presente em lib/models\locations_services\cepaberto_map_api.dart |
| CepAbertoAddress | lib/models\locations_services\cepaberto_map_api.dart | class | Classe presente em lib/models\locations_services\cepaberto_map_api.dart |
| City | lib/models\locations_services\cepaberto_map_api.dart | class | Classe presente em lib/models\locations_services\cepaberto_map_api.dart |
| State | lib/models\locations_services\cepaberto_map_api.dart | class | Classe presente em lib/models\locations_services\cepaberto_map_api.dart |
| fromMap(Map<String, dynamic> map) | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| tryParse(map["latitude"] as String? ?? "") | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| tryParse(map["longitude"] as String? ?? "") | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| fromMap(map["cidade"] as Map<String, dynamic>) | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| fromMap(map["estado"] as Map<String, dynamic>) | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| toString() | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| fromMap(Map<String, dynamic> map) | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| toString() | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| fromMap(Map<String, dynamic> map) | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| toString() | lib/models\locations_services\cepaberto_map_api.dart | common | Função/método em lib/models\locations_services\cepaberto_map_api.dart |
| for | lib/models\locations_services\viacep_map_api.dart | class | Classe presente em lib/models\locations_services\viacep_map_api.dart |
| utilizes | lib/models\locations_services\viacep_map_api.dart | class | Classe presente em lib/models\locations_services\viacep_map_api.dart |
| LocationService | lib/models\locations_services\viacep_map_api.dart | class | Classe presente em lib/models\locations_services\viacep_map_api.dart |
| ViaCepAddress | lib/models\locations_services\viacep_map_api.dart | class | Classe presente em lib/models\locations_services\viacep_map_api.dart |
| getCurrentLocation() | lib/models\locations_services\viacep_map_api.dart | common | Função/método em lib/models\locations_services\viacep_map_api.dart |
| getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ) | lib/models\locations_services\viacep_map_api.dart | common | Função/método em lib/models\locations_services\viacep_map_api.dart |
| ViaCepAddress({
    this.longitude,
    this.latitude,
    required this.cep,
    this.streetAddress,
    this.district,
    this.city,
    this.state,
    this.ddd,
    this.ibge,
  }) | lib/models\locations_services\viacep_map_api.dart | common | Função/método em lib/models\locations_services\viacep_map_api.dart |
| fromMap(Map<String, dynamic> map, {double? latitude, double? longitude}) | lib/models\locations_services\viacep_map_api.dart | common | Função/método em lib/models\locations_services\viacep_map_api.dart |
| ViaCepAddress(
      longitude: longitude,
      latitude: latitude,
      cep: map["cep"] as String,
      streetAddress: map["logradouro"] as String? ?? "",
      district: map["bairro"] as String? ?? "",
      city: map["localidade"] as String? ?? "",
      state: map["uf"] as String? ?? "",
      ddd: map["ddd"] as String? ?? "",
      ibge: map["ibge"] as String? ?? "",
    ) | lib/models\locations_services\viacep_map_api.dart | common | Função/método em lib/models\locations_services\viacep_map_api.dart |
| toString() | lib/models\locations_services\viacep_map_api.dart | common | Função/método em lib/models\locations_services\viacep_map_api.dart |
| responsible | lib/models\policy_documents\policy_and_documents.dart | class | Classe presente em lib/models\policy_documents\policy_and_documents.dart |
| PolicyAndDocuments | lib/models\policy_documents\policy_and_documents.dart | class | Classe presente em lib/models\policy_documents\policy_and_documents.dart |
| setAgreedToPolicyTerms(bool value) | lib/models\policy_documents\policy_and_documents.dart | common | Sets the agreement status for policy and terms. |
| notifyListeners() | lib/models\policy_documents\policy_and_documents.dart | common | Função/método em lib/models\policy_documents\policy_and_documents.dart |
| setAgreedToTermsOfService(bool value) | lib/models\policy_documents\policy_and_documents.dart | common | Sets the agreement status for terms of service. |
| notifyListeners() | lib/models\policy_documents\policy_and_documents.dart | common | Função/método em lib/models\policy_documents\policy_and_documents.dart |
| representing | lib/models\products\cart_product.dart | class | Classe presente em lib/models\products\cart_product.dart |
| manages | lib/models\products\cart_product.dart | class | Classe presente em lib/models\products\cart_product.dart |
| CartProduct | lib/models\products\cart_product.dart | class | Classe presente em lib/models\products\cart_product.dart |
| fromProduct(this._product, this._detailsProducts) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| getColorFromString(color!) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| fromDocument(DocumentSnapshot document) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get("pid") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get("brand") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get("freight") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get("quantity") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get("size") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get("color") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| getColorFromString(color!) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| doc("products/$productId") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| then((doc) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| fromDocument(doc) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| fromMap(Map<String, dynamic> map) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| getColorFromString(color!) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| doc("products/$productId") | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| get() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| then((doc) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| fromDocument(doc) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| toCartItemMap() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| toOrderItemMap() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| stackableSize(Product product) | lib/models\products\cart_product.dart | bool | /// The [product] parameter represents the product to compare with. |
| increment() | lib/models\products\cart_product.dart | common | Increases the quantity of the cart product by one unit. |
| notifyListeners() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| decrement() | lib/models\products\cart_product.dart | common | Decreases the quantity of the cart product by one unit. |
| notifyListeners() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| product(Product? value) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| notifyListeners() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| detailsProductsFindValues(DetailsProducts? value) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| notifyListeners() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| findSize(size!) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| findAmountByColor(color) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| freight(bool? value) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| notifyListeners() | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| findAmountByColor(color) | lib/models\products\cart_product.dart | common | Função/método em lib/models\products\cart_product.dart |
| includes | lib/models\products\categories\product_category.dart | class | Classe presente em lib/models\products\categories\product_category.dart |
| ProductCategory | lib/models\products\categories\product_category.dart | class | Classe presente em lib/models\products\categories\product_category.dart |
| ProductCategory({
    this.categoryID,
    this.categoryTitle,
    this.categoryRealColor,
    this.categoryImg,
    this.categoryActivated,
    this.subCategoryList,
    this.categoryColor,
  }) | lib/models\products\categories\product_category.dart | common | Creates a [ProductCategory] object with the specified parameters. |
| fromDocument(DocumentSnapshot document) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| PerformanceMonitoring() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| startTrace('categoryFromMap', shouldStart: true) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| MonitoringLogger() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| logInfo('Message: CategoryFromMap') | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| getColorFromString(categoryColor ?? "") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| map((d) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| fromMap(d as Map<String, dynamic>) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| toList() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| PerformanceMonitoring() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| stopTrace('categoryFromMap') | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| toMap() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| getHexColor(categoryRealColor ?? Colors.blueGrey) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| exportSubCategories() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| doc("categories/$categoryID") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| ref() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| child("categories") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| child("$categoryID!") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| s() | lib/models\products\categories\product_category.dart | common | List<Map<String, dynamic>>? exportSubCategorie |
| t() | lib/models\products\categories\product_category.dart | common | return subCategoryList?.map((sub) => sub.toMap()).toLis |
| exportSubCategories() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| map((sub) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| toMap() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| toList() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| updateCategoryImage(dynamic image) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| PerformanceMonitoring() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| startTrace('update-category-image', shouldStart: true) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| MonitoringLogger() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| logInfo('Starting file upload Category') | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| refFromURL(categoryImg) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| delete() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| split(',') | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| replaceAll(RegExp("[^$validCharacters]") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| decode(trimmedString!) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| fromList(bytes) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| SettableMetadata(contentType: "image/jpeg") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| child("$categoryID!") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| putData(uint8ListBytes, metadata) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| whenComplete(() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| getDownloadURL() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| print('Erro ao decodificar o base64String: $e') | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| child("$categoryID!") | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| putFile(image) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| whenComplete(() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| getDownloadURL() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| update({"categoryImg": image}) | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| notifyListeners() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| PerformanceMonitoring() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| stopTrace('update-category-image') | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| toString() | lib/models\products\categories\product_category.dart | common | Função/método em lib/models\products\categories\product_category.dart |
| responsible | lib/models\products\categories\product_category_manager.dart | class | Classe presente em lib/models\products\categories\product_category_manager.dart |
| ProductCategoryManager | lib/models\products\categories\product_category_manager.dart | class | Classe presente em lib/models\products\categories\product_category_manager.dart |
| ProductCategoryManager() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| verifyUser(userManager ?? UserManager() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| verifyCategoriesList() | lib/models\products\categories\product_category_manager.dart | bool | /// Returns `true` if the list is empty; otherwise, returns `false`. |
| updateCategory() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| MonitoringLogger() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| logInfo('Update Category to Firebase') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| get() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| firstWhere((doc) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toMap() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| data() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| mapEquals(data, dbData) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| doc(category.categoryID) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| update(data) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| verifyUser(UserManager userManager) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| cancel() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| clear() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| _setupRealTimeUpdatesAllCategories() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| clear() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| _loadCategoriesForUsers() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| _loadCategoriesForUsers() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| MonitoringLogger() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| logInfo('Info _loadCategoriesForUSERS') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| where("categoryActivated", isEqualTo: true) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| get(const GetOptions(source: Source.cache) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| map((category) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| fromDocument(category) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toList() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| where("categoryActivated", isEqualTo: true) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| snapshots() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| listen((event) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| map((s) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| fromDocument(s) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toList() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| PerformanceMonitoring() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| stopTrace('_loadCategoriesList') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| saveGalleryVisit({
    required Users user,
    required String categoryId,
  }) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| debugPrint("Usuário sem ID!") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| get() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| data() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| update({'galleries': galleries}) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| debugPrint('Galeria visitada: $categoryId -> ${galleries[categoryId]}') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| visitCategory(String categoryId, Users user) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| saveGalleryVisit(
      user: user,
      categoryId: categoryId,
    ) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| debugPrint("Categoria visitada: $categoryId") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| getProductsByVisitedGalleries(
    Users user,
    List<Product> allProducts,
  ) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection('users') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| doc(user.id) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| get() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| data() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toList() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| sort((a, b) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| compareTo(a.value as int) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| where((p) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| take(3) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toList() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| addAll(galleryProducts) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| loadSuggestionsBasedOnVisitGalleryProducts(BuildContext context) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| getProductsByVisitedGalleries(
      userManager.users!,
      productManager.allProducts,
    ) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| _setupRealTimeUpdatesAllCategories() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| PerformanceMonitoring() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| startTrace('setup-rt-updates-categories', shouldStart: true) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| MonitoringLogger() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| logInfo('Info message: _categoriesListener Start ') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| snapshots() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| listen((event) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| map((s) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| fromDocument(s) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toList() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| notifyListeners() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| PerformanceMonitoring() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| stopTrace('setup-rt-updates-categories') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| filterCategoriesActivated(bool adminEnable, bool editingCategories) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| addAll(
          _categoriesList.toList() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| sort((a, b) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| compareTo(b.categoryTitle!) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| addAll(
          _categoriesList.where((category) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toList() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| sort((a, b) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| compareTo(b.categoryTitle!) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| createProductCategoriesIfNotExists({required bool firstStart}) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| MonitoringLogger() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| logInfo('Info: Creating Categories') | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| get() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| any((doc) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| doc(category.categoryID) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| set(category.toMap() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| where(
              (doc) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| any((category) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| collection("categories") | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| doc(docToDelete.id) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| delete() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| firstWhere((doc) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| toMap() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| data() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| forEach((key, value) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| containsKey(key) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| set(dbData) | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| dispose() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| cancel() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| dispose() | lib/models\products\categories\product_category_manager.dart | common | Função/método em lib/models\products\categories\product_category_manager.dart |
| representing | lib/models\products\categories\product_sub_category.dart | class | Classe presente em lib/models\products\categories\product_sub_category.dart |
| encapsulates | lib/models\products\categories\product_sub_category.dart | class | Classe presente em lib/models\products\categories\product_sub_category.dart |
| SubCategory | lib/models\products\categories\product_sub_category.dart | class | Classe presente em lib/models\products\categories\product_sub_category.dart |
| SubCategory({this.subCategoryID, this.subCategoryTitle, this.iconSubCategories, this.productID}) | lib/models\products\categories\product_sub_category.dart | common | /// The [subCategoryID], [subCategoryTitle], [iconSubCategories], and [productID] parameters are optional and default to `null`. |
| fromMap(Map<String, dynamic> map) | lib/models\products\categories\product_sub_category.dart | common | Função/método em lib/models\products\categories\product_sub_category.dart |
| toMap() | lib/models\products\categories\product_sub_category.dart | common | Função/método em lib/models\products\categories\product_sub_category.dart |
| representing | lib/models\products\colors_products.dart | class | Classe presente em lib/models\products\colors_products.dart |
| manages | lib/models\products\colors_products.dart | class | Classe presente em lib/models\products\colors_products.dart |
| ColorsProducts | lib/models\products\colors_products.dart | class | Classe presente em lib/models\products\colors_products.dart |
| ColorsProducts({
    this.color,
    required this.amount,
    this.realColor,
  }) | lib/models\products\colors_products.dart | common | The [realColor] parameter represents the actual color representation. |
| fromMap(Map<String, dynamic> map) | lib/models\products\colors_products.dart | common | Função/método em lib/models\products\colors_products.dart |
| getColorFromString(color!) | lib/models\products\colors_products.dart | common | Função/método em lib/models\products\colors_products.dart |
| notifyListeners() | lib/models\products\colors_products.dart | common | Função/método em lib/models\products\colors_products.dart |
| toMap() | lib/models\products\colors_products.dart | common | Função/método em lib/models\products\colors_products.dart |
| clone() | lib/models\products\colors_products.dart | common | /// This method is used to create a separate instance of the color object with the same properties. |
| ColorsProducts(
      realColor: realColor,
      color: color,
      amount: amount,
    ) | lib/models\products\colors_products.dart | common | Função/método em lib/models\products\colors_products.dart |
| toString() | lib/models\products\colors_products.dart | common | Função/método em lib/models\products\colors_products.dart |
| representing | lib/models\products\details_products.dart | class | Classe presente em lib/models\products\details_products.dart |
| manages | lib/models\products\details_products.dart | class | Classe presente em lib/models\products\details_products.dart |
| DetailsProducts | lib/models\products\details_products.dart | class | Classe presente em lib/models\products\details_products.dart |
| DetailsProducts({
    this.size,
    this.price,
    required this.stock,
    this.colorProducts,
    this.sellers = 0,
  }) | lib/models\products\details_products.dart | common | The [sellers] parameter represents the number of sellers offering this variant. |
| fromMap(Map<String, dynamic> map) | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| map((d) | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| fromMap(d as Map<String, dynamic>) | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| toList() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| toMap() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| map((colors) | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| toMap() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| toList() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| findAmountByColor(String? color) | lib/models\products\details_products.dart | common | Returns the [ColorsProducts] object corresponding to the provided color name, if found; otherwise, returns null. |
| firstWhere((a) | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| areAllColorsEmpty(Product? product) | lib/models\products\details_products.dart | bool | Returns true if all color variations are empty or if the product has no variations; otherwise, returns false. |
| any((colors) | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| clone() | lib/models\products\details_products.dart | common | /// This method is used to create a separate instance of the product variant object with the same properties. |
| DetailsProducts(
      size: size,
      price: price,
      stock: stock,
      sellers: sellers,
      colorProducts: colorProducts?.map((colors) | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| clone() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| toList() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| selectedColors(ColorsProducts? value) | lib/models\products\details_products.dart | common | Sets the currently selected color variant. |
| notifyListeners() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| toString() | lib/models\products\details_products.dart | common | Função/método em lib/models\products\details_products.dart |
| representing | lib/models\products\product.dart | class | Classe presente em lib/models\products\product.dart |
| handles | lib/models\products\product.dart | class | Classe presente em lib/models\products\product.dart |
| Product | lib/models\products\product.dart | class | Classe presente em lib/models\products\product.dart |
| Product({
    this.id,
    this.name,
    this.description,
    this.images,
    this.itemProducts,
    this.deleted = false,
    this.advertising = false,
    this.isValid,
    this.stockErrorMessage,
    this.details,
    this.brand = "",
    this.freight,
    this.categoryOfProduct = "",
    this.insertionDate,
    this.highlight = false,
  }) | lib/models\products\product.dart | common | /// The constructor allows setting various properties of the product. |
| DetailsProducts(stock: 0) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| fromDocument(DocumentSnapshot document) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| PerformanceMonitoring() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| startTrace('product-document', shouldStart: true) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| MonitoringLogger() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| logInfo('Debug message: Instance Product.fromDocument') | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| from(document["images"] as List<dynamic>) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| now() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| map((d) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| fromMap(d as Map<String, dynamic>) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| toList() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| PerformanceMonitoring() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| stopTrace('product-document') | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| toMap() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| exportDetailsList() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| now() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| doc("products/$id") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| ref() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| child("products") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| child(id!) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| loading(bool value) | lib/models\products\product.dart | common | Sets the loading state of the product. |
| notifyListeners() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| selectedDetails(DetailsProducts? value) | lib/models\products\product.dart | common | Sets the selected details of the product. |
| notifyListeners() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| findSize(String name) | lib/models\products\product.dart | common | Finds and returns details related to a specific size. |
| firstWhere((s) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| exportDetailsList() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| map((details) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| toMap() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| toList() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| saveProduct() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| PerformanceMonitoring() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| startTrace('save_product', shouldStart: true) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| MonitoringLogger() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| logDebug('Debug message: Instance starting saveProduct') | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| collection("products") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| add(toMap() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update(toMap() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| contains(newImage) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| add(newImage as String) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| decode(newImage.split(',') | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| fromList(bytes) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| SettableMetadata(contentType: "image/jpeg") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| child(const Uuid() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| v4() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| putData(uint8ListBytes, metadata) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| whenComplete(() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| getDownloadURL() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| add(url) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| child(const Uuid() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| v4() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| putFile(newImage as File) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| whenComplete(() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| getDownloadURL() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| add(url) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| contains(image) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| contains("firebase") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| refFromURL(image) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| delete() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update({"images": updateImages}) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| PerformanceMonitoring() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| stopTrace('save_product') | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| MonitoringLogger() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| logDebug('Debug message: Instance ending saveProduct') | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| deleteProductWithZeroStockOneImage() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| map((details) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| toMap() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| toList() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update({"details": updatedDetailsList}) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| contains("firebase") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| refFromURL(image) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| delete() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| from(images!) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update({
      "images": images,
    }) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update(toMap() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update({"isvalid": false}) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| notifyListeners() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| deleteProduct() | lib/models\products\product.dart | common | Deletes the product from Firestore and associated images. |
| deleteProductWithZeroStockOneImage() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update({"deleted": true}) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| notifyListeners() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| checkAmountsAndStocksConsistency(
      String productId, List<DetailsProducts> detailsProducts) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| firstWhere((details) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| fold(0, (a, b) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| collection("products") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| doc(productId) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update({"isvalid": false}) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| collection("products") | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| doc(productId) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| update({"isvalid": true}) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| notifyListeners() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| cloneProduct() | lib/models\products\product.dart | common | Clones the current product instance. |
| Product(
      id: id,
      name: name,
      brand: brand,
      freight: freight ?? true,
      description: description,
      images: List.from(images!) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| map((items) | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| clone() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| toList() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| now() | lib/models\products\product.dart | common | Função/método em lib/models\products\product.dart |
| responsible | lib/models\products\product_manager.dart | class | Classe presente em lib/models\products\product_manager.dart |
| handles | lib/models\products\product_manager.dart | class | Classe presente em lib/models\products\product_manager.dart |
| ProductManager | lib/models\products\product_manager.dart | class | Classe presente em lib/models\products\product_manager.dart |
| ProductManager() | lib/models\products\product_manager.dart | common | Initialize an instance of [Product Manager] and start listening for products. |
| _listenToProducts() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| ProductsBestSelling(
      allProducts: allProducts,
      salesThreshold: 15, // Set the appropriate sales margin
    ) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| ProductsRecentlyAdded(
      allProducts: allProducts,
    ) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| ProductsLowestSelling(
      allProducts: allProducts,
    ) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((p) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| search(String value) | lib/models\products\product_manager.dart | common | Sets the search query and notifies listeners. |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| from(allProducts) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toLowerCase() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((p) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toLowerCase() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(searchQuery) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.bestSellers) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| getBestSellingProducts(15) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.lowestSellers) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| getLowestSellingProducts(count: 15) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.recentlyAdded) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| getRecentProducts(productCategory: null) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.lowestPrice) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| sort((a, b) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| compareTo(b.basePrice) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.brand) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| trim() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| sort((a, b) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| compareTo(b.brand) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.freight) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where((product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| toList() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.sortedAZ) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| sort((a, b) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| compareTo(b.name!) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| contains(StatusOfProducts.sortedZA) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| sort((a, b) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| compareTo(a.name!) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| _listenToProducts() | lib/models\products\product_manager.dart | common | Starts listening for products in Firestore. |
| PerformanceMonitoring() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| startTrace('listen_products', shouldStart: true) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| MonitoringLogger() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| logInfo('Starting listen products') | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| collection("products") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where("deleted", isEqualTo: false) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| where("isvalid", isEqualTo: true) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| snapshots() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| listen((event) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| clear() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("name") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("deleted") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("advertising") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("isvalid") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("brand") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("freight") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("description") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("images") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("categoryOfProduct") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("insertionDate") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("highlight") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| data() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| containsKey("details") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| add(Product.fromDocument(product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| PerformanceMonitoring() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| stopTrace('listen_products') | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| findProductById(String id) | lib/models\products\product_manager.dart | common | Search for a product by its ID. |
| firstWhere((p) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| updateProducts(Product product) | lib/models\products\product_manager.dart | common | Updates the product list with an updated product. |
| removeWhere((p) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| add(product) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| requestDelete(Product product) | lib/models\products\product_manager.dart | common | Requests the deletion of a product. |
| deleteProduct() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| removeWhere((p) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| disableFilter() | lib/models\products\product_manager.dart | common | Disables all filters. |
| clear() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| clear() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| clear() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| setStatusFilter({StatusOfProducts? status, bool? enabled}) | lib/models\products\product_manager.dart | common | Sets the products state filter and notifies listeners. |
| add(status!) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| add(status) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| setActiveFilterName(getStatusText(selectedFiltersByUser[0]) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| remove(status) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| setActiveFilterName("") | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| clear() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| setActiveFilterName(String name) | lib/models\products\product_manager.dart | common | Defines the name of the currently active filter. |
| notifyListeners() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| getStatusText(status!) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| getStatusText(StatusOfProducts status) | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| dispose() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| cancel() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| clear() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| clear() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| disableFilter() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| dispose() | lib/models\products\product_manager.dart | common | Função/método em lib/models\products\product_manager.dart |
| representing | lib/models\sales\cart_manager.dart | class | Classe presente em lib/models\sales\cart_manager.dart |
| is | lib/models\sales\cart_manager.dart | class | Classe presente em lib/models\sales\cart_manager.dart |
| CartManager | lib/models\sales\cart_manager.dart | class | Classe presente em lib/models\sales\cart_manager.dart |
| _internal() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _internal() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| any((product) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| loading(bool value) | lib/models\sales\cart_manager.dart | common | Sets the loading state of the cart. |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| updateUser(UserManager userManager) | lib/models\sales\cart_manager.dart | common | Updates the user information and loads the cart items and user address. |
| MonitoringLogger() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| logInfo('Start Load User Cart') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| clear() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| removeAddress() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| addPostFrameCallback((_) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _loadCartItems() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _loadUserAddress() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| addPostFrameCallback((_) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _loadCartItems() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| MonitoringLogger() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| logInfo('Start Load Cart Items') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| get() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| map((d) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| fromDocument(d) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| addListener(_onItemUpdate) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| toList() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _loadUserAddress() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| MonitoringLogger() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| logInfo('Start Load Cart Address') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| setAddress(users!.address!) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| addToCart(Product product, DetailsProducts detailsProducts) | lib/models\sales\cart_manager.dart | common | Adds a product to the cart with the specified details. |
| MonitoringLogger() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| logInfo('Info message: Add to Cart') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| firstWhere((p) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| stackableSize(product) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| increment() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| fromProduct(product, detailsProducts) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| addListener(_onItemUpdate) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| add(cartProduct) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| add(cartProduct.toCartItemMap() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| then((doc) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _onItemUpdate() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| removeOfCart(CartProduct cartProduct) | lib/models\sales\cart_manager.dart | common | Removes a product from the cart. |
| removeWhere((p) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| doc(cartProduct.id) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| delete() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| removeListener(_onItemUpdate) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| clearCart() | lib/models\sales\cart_manager.dart | common | Clears the entire cart, removing all items. |
| doc(cartProduct.id) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| delete() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| clear() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _onItemUpdate() | lib/models\sales\cart_manager.dart | common | Handles cart item updates, recalculating prices and updating product details. |
| removeOfCart(cartProduct) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _updateCartProduct(cartProduct) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| _updateCartProduct(CartProduct cartProduct) | lib/models\sales\cart_manager.dart | common | Updates the cart product details in Firestore. |
| doc(cartProduct.id) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| update(cartProduct.toCartItemMap() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| update({"favourite": true}) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| setAddress(users!.address!) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| getAddress(String cep) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| MonitoringLogger() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| logInfo('Info message: Start Load Get Address Cart') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| ViaCepApi() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| getAddressFromZipCode(cep) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| getCurrentLocation() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| Address(
          zipCode: viaCepAddress.cep,
          city: viaCepAddress.city,
          state: viaCepAddress.state,
          street: viaCepAddress.streetAddress,
          district: viaCepAddress.district,
          //TODO: 2-2 Substituir por linhas abaixo comentada após configurar CORS para acesso
          lat: latitude,
          long: longitude,
          //TODO: 1-2 Permissão CORS -> Access-Control-Allow-Origin' configurar
          // lat: cepAbertoAddress.latitude,
          // long: cepAbertoAddress.longitude,
        ) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| error('CEP Inválido!\nFavor conferir o CEP e tente em instantes. Obrigado.') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| CepAbertoApi() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| getAddressFromZipCode(cep) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| Address(
          zipCode: cepAbertoAddress.cep,
          city: cepAbertoAddress.city!.cityName,
          state: cepAbertoAddress.state!.code,
          street: cepAbertoAddress.streetAddress,
          district: cepAbertoAddress.district,
          lat: cepAbertoAddress.latitude,
          long: cepAbertoAddress.longitude,
        ) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| error('CEP inválido!\nFavor conferir o CEP e tente em instantes, obrigado.') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| setAddress(Address address) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| calculateDelivery(address.lat!, address.long!) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| setAddress(address) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| error('Endereço fora do raio de entrega :(') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| calculateDelivery(double lat, double long) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| MonitoringLogger() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| logInfo('Info message: Start Calculate Delivery Cart') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| doc("aux/delivery") | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| get() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| get("lat") | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| get("long") | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| get("basePrice") | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| get("km") | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| get("maxKm") | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| distanceBetween(latStore, longStore, lat, long) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| error('Erro ao calcular Frete $error') | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| removeAddress() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| addPostFrameCallback((_) | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| notifyListeners() | lib/models\sales\cart_manager.dart | common | Função/método em lib/models\sales\cart_manager.dart |
| representing | lib/models\sales\checkout_manager.dart | class | Classe presente em lib/models\sales\checkout_manager.dart |
| handles | lib/models\sales\checkout_manager.dart | class | Classe presente em lib/models\sales\checkout_manager.dart |
| CheckoutManager | lib/models\sales\checkout_manager.dart | class | Classe presente em lib/models\sales\checkout_manager.dart |
| loading(bool value) | lib/models\sales\checkout_manager.dart | common | Sets the loading state of the checkout process. |
| notifyListeners() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| updateCart(CartManager cartManager) | lib/models\sales\checkout_manager.dart | common | Updates the cart manager instance for checkout. |
| notifyListeners() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| checkout({
    required Function onStockFail,
    required Function onSuccess,
  }) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| onStockFail('CartManager não inicializado') | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _checkConsistenceOfCounterAndOrders() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _decrementStock() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| onStockFail(error) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _getOrderId() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| fromCartManager(cartManager!) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| toString() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| saveOrder() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _savePurchase() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| clearCart() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| onSuccess(order) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| notifyListeners() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _checkConsistenceOfCounterAndOrders() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| doc("aux/orderCounter") | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| get() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| get("current") | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| collection("orders") | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| get() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| tryParse(orderDoc.id) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _getOrderId() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _checkConsistenceOfCounterAndOrders() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| doc("aux/orderCounter") | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| runTransaction((tx) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| get(transactionRef) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| get("current") | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| update(transactionRef, {"current": orderId + 1}) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| error('Falha ao gerar número do pedido!: ${error.toString() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _decrementStock() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| runTransaction((tx) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| get(firestore.doc("products/${cartProduct.productId}") | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| fromDocument(doc) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| findSize(cartProduct.size!) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| add(product) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| firstWhere((color) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| add(product) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| error('${productsWithoutStock.length} Estoque modificado antes da compra!'
            'Favor verificar quantidade disponível!') | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| update(
            firestore.doc("products/${product.id}") | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| exportDetailsList() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| checkMinimumStock(productsToUpdate, productsWithoutStock) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| _savePurchase() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| map((e) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| toList() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| PurchaseModel(
      userId: cartManager!.users!.id!,
      items: productIds,
      createdAt: DateTime.now() | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| savePurchase(purchase) | lib/models\sales\checkout_manager.dart | common | Função/método em lib/models\sales\checkout_manager.dart |
| representing | lib/models\sales\delivery.dart | class | Classe presente em lib/models\sales\delivery.dart |
| contains | lib/models\sales\delivery.dart | class | Classe presente em lib/models\sales\delivery.dart |
| Delivery | lib/models\sales\delivery.dart | class | Classe presente em lib/models\sales\delivery.dart |
| Delivery({
    this.basePrice,
    this.km,
    this.lat,
    this.long,
    this.maxKm,
  }) | lib/models\sales\delivery.dart | common | Initializes a [Delivery] instance with the specified parameters. |
| fromMap(Map<String, dynamic> map) | lib/models\sales\delivery.dart | common | Função/método em lib/models\sales\delivery.dart |
| toMap() | lib/models\sales\delivery.dart | common | Função/método em lib/models\sales\delivery.dart |
| responsible | lib/models\sales\orders_manager.dart | class | Classe presente em lib/models\sales\orders_manager.dart |
| handles | lib/models\sales\orders_manager.dart | class | Classe presente em lib/models\sales\orders_manager.dart |
| OrdersManager | lib/models\sales\orders_manager.dart | class | Classe presente em lib/models\sales\orders_manager.dart |
| updateUser(Users users) | lib/models\sales\orders_manager.dart | common | Updates the user data and starts listening to orders. |
| clear() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| cancel() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| MonitoringLogger() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| logInfo('Info: ${_subscription?.cancel() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| _listenToOrders() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| _listenToOrders() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| PerformanceMonitoring() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| startTrace('listen-orders', shouldStart: true) | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| MonitoringLogger() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| logInfo('Info: listenToOrders') | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| collection("orders") | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| where("user", isEqualTo: users!.id) | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| snapshots() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| listen((events) | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| clear() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| add(OrderClient.fromDocument(document) | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| notifyListeners() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| PerformanceMonitoring() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| stopTrace('listen-orders') | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| dispose() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| cancel() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| dispose() | lib/models\sales\orders_manager.dart | common | Função/método em lib/models\sales\orders_manager.dart |
| representing | lib/models\sales\order_client.dart | class | Classe presente em lib/models\sales\order_client.dart |
| handles | lib/models\sales\order_client.dart | class | Classe presente em lib/models\sales\order_client.dart |
| OrderClient | lib/models\sales\order_client.dart | class | Classe presente em lib/models\sales\order_client.dart |
| collection("orders") | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| doc(orderId) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| fromCartManager(CartManager cartManager) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| from(cartManager.items) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| fromDocument(DocumentSnapshot doc) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| MonitoringLogger() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| logInfo('Info: OrderClient.fromDocument') | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| map((e) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| fromMap(e as Map<String, dynamic>) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| toList() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| fromMap(doc["address"] as Map<String, dynamic>) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| formattedOrderId(orderId) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getStatusText(status!) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getNextStatusText(status!) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getPreviousStatusText(status!) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getBodyText(status!) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| updateFromDocument(DocumentSnapshot doc) | lib/models\sales\order_client.dart | common | Updates the order status based on a Firestore document snapshot. |
| saveOrder() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| PerformanceMonitoring() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| startTrace('save-order', shouldStart: true) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| collection("orders") | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| doc(orderId) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| set({
      "items": items?.map((e) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| toOrderItemMap() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| toList() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| toMap() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| now() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| PerformanceMonitoring() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| stopTrace('save-order') | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| Function() | lib/models\sales\order_client.dart | common | Gets the function to go back in status, if applicable. |
| update({"status": status!.index}) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| Function() | lib/models\sales\order_client.dart | common | Gets the function to advance in status, if applicable. |
| update({"status": status!.index}) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| cancelStatus() | lib/models\sales\order_client.dart | common | Cancels the order status. |
| update({"status": status!.index}) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getStatusText(StatusOfOrders status) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getNextStatusText(StatusOfOrders status) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getPreviousStatusText(StatusOfOrders status) | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| getBodyText(StatusOfOrders status) | lib/models\sales\order_client.dart | common | Returns the body text based on the current order status. |
| padLeft(6, '0') | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| toString() | lib/models\sales\order_client.dart | common | Função/método em lib/models\sales\order_client.dart |
| representing | lib/models\stores\opening_stores.dart | class | Classe presente em lib/models\stores\opening_stores.dart |
| provides | lib/models\stores\opening_stores.dart | class | Classe presente em lib/models\stores\opening_stores.dart |
| OpeningStores | lib/models\stores\opening_stores.dart | class | Classe presente em lib/models\stores\opening_stores.dart |
| OpeningStores({
    this.monFri,
    this.saturday,
    this.monday,
  }) | lib/models\stores\opening_stores.dart | common | Initializes an [OpeningStores] instance with optional opening hours for different days. |
| fromMap(Map<String, dynamic> map) | lib/models\stores\opening_stores.dart | common | Função/método em lib/models\stores\opening_stores.dart |
| toMap() | lib/models\stores\opening_stores.dart | common | Função/método em lib/models\stores\opening_stores.dart |
| Stores | lib/models\stores\stores.dart | class | Classe presente em lib/models\stores\stores.dart |
| Stores({
    this.id,
    this.nameStore,
    this.emailStore,
    this.phoneNumberStore,
    this.imageStore,
    this.openingStores,
    this.address,
  }) | lib/models\stores\stores.dart | common | Constructor for the Stores class. |
| fromDocument(DocumentSnapshot document) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| PerformanceMonitoring() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| startTrace('stores-from-document', shouldStart: true) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| MonitoringLogger() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| logInfo('Instance beginning Stores.fromDocument') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| get("nameStore") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| get("emailStore") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| get("phoneNumberStore") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| get("imageStore") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| fromMap(document.get("address") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| fromMap(document.get("openingStores") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| get("openingStores") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| map((key, value) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| split(RegExp(r"[:-]") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| MapEntry(key, {
          "from": TimeOfDay(
            hour: int.parse(splitted[0]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| parse(splitted[1]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| TimeOfDay(
            hour: int.parse(splitted[2]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| parse(splitted[3]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| MapEntry(key, null) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| updateStatus() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| PerformanceMonitoring() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| stopTrace('stores-from-document') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| ref() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| child("stores") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| formattedZipcode(address?.zipCode) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| formattedPeriod(openingStoresFromTimeOfDay!["monFri"]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| formattedPeriod(openingStoresFromTimeOfDay!["saturday"]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| formattedPeriod(openingStoresFromTimeOfDay!["monday"]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| fromARGB(255, 210, 179, 7) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMap() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| unFormatPhone(phoneNumberStore ?? "") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMap() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMap() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| formattedPeriod(Map<String, TimeOfDay>? period) | lib/models\stores\stores.dart | common | Formats the time period. |
| formatted() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| formatted() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| updateStore(String storeId, Stores store) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| collection("stores") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| doc(storeId) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| update(store.toMap() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| updateStoreImage(imageStore, storeId) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| print(error) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| notifyListeners() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| saveStore(Stores store) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| PerformanceMonitoring() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| startTrace('save-store', shouldStart: true) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| MonitoringLogger() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| logInfo('Save file upload to Firebase Storage') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| collection("stores") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| add(store.toMap() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| updateStoreImage(imageStore, store.id) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| print(error) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| notifyListeners() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| PerformanceMonitoring() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| stopTrace('save-store') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| MonitoringLogger() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| logInfo('File saved completed') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| deleteStore(Stores store, String? storeId) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| MonitoringLogger() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| logInfo('Starting file delete to Firebase Storage') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| collection("stores") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| doc(storeId) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| contains("firebase") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| refFromURL(store.imageStore!) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| delete() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| delete() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| print(error) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| notifyListeners() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| updateStoreImage(dynamic image, [String? storeId]) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| PerformanceMonitoring() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| startTrace('update-store-image', shouldStart: true) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| MonitoringLogger() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| logInfo('Starting file upload to Firebase Storage') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| contains("firebase") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| refFromURL(imageStore) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| delete() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| split(',') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| replaceAll(RegExp("[^$validCharacters]") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| decode(trimmedString!) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| fromList(bytes) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| SettableMetadata(contentType: "image/jpeg") | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| child(const Uuid() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| v4() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| putData(uint8ListBytes, metadata) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| whenComplete(() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| getDownloadURL() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| print('Erro ao decodificar o base64String: $e') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| child(const Uuid() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| v4() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| putFile(image) | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| whenComplete(() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| getDownloadURL() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| notifyListeners() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| PerformanceMonitoring() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| stopTrace('update-store-image') | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| updateStatus() | lib/models\stores\stores.dart | common | Updates the store status. |
| now() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| now() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| toMinutes() | lib/models\stores\stores.dart | common | Função/método em lib/models\stores\stores.dart |
| provides | lib/models\stores\stores_manager.dart | class | Classe presente em lib/models\stores\stores_manager.dart |
| StoresManager | lib/models\stores\stores_manager.dart | class | Classe presente em lib/models\stores\stores_manager.dart |
| StoresManager([this.stores, this.address]) | lib/models\stores\stores_manager.dart | common | Constructs a StoresManager instance with optional initial stores and address. |
| _loadStoreList() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| _startTime() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| _setupRealTimeUpdates() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| _loadStoreList() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| PerformanceMonitoring() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| startTrace('load-store-list', shouldStart: true) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| collection("stores") | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| get(const GetOptions(source: Source.cache) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| map((s) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| fromDocument(s) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| toList() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| notifyListeners() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| PerformanceMonitoring() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| stopTrace('load-store-list') | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| _startTime() | lib/models\stores\stores_manager.dart | common | Starts a timer to perform periodic checks on store statuses. |
| PerformanceMonitoring() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| startTrace('start-time', shouldStart: true) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| periodic(
      const Duration(minutes: 1) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| _checkOpening() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| PerformanceMonitoring() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| stopTrace('start-time') | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| _checkOpening() | lib/models\stores\stores_manager.dart | common | Checks and updates the opening status of all stores in the list. |
| updateStatus() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| notifyListeners() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| _setupRealTimeUpdates() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| PerformanceMonitoring() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| startTrace('setup-rt-updates', shouldStart: true) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| MonitoringLogger() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| logInfo('Info message: _storesListener Start ') | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| collection("stores") | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| snapshots() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| listen(
      (event) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| map((s) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| fromDocument(s) | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| toList() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| notifyListeners() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| PerformanceMonitoring() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| stopTrace('setup-rt-updates') | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| dispose() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| cancel() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| cancel() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| dispose() | lib/models\stores\stores_manager.dart | common | Função/método em lib/models\stores\stores_manager.dart |
| representing | lib/models\users\users.dart | class | Classe presente em lib/models\users\users.dart |
| contains | lib/models\users\users.dart | class | Classe presente em lib/models\users\users.dart |
| Users | lib/models\users\users.dart | class | Classe presente em lib/models\users\users.dart |
| doc("users/$id") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| collection("cart") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| Users({
    this.id,
    this.userName,
    required this.email,
    this.favourite,
    this.phoneNumber,
    this.userPhotoURL,
    this.policyAndTerms,
    this.password,
    this.confirmPassword,
  }) | lib/models\users\users.dart | common | Initializes a [Users] instance with the specified parameters. |
| fromDocument(DocumentSnapshot document) | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| get("name") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| get("email") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| get("favourite") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| get("phone") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| get("userPhoto") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| get("policyAndTerms") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| data() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| from(dataMap["favorites"] ?? []) | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| from(dataMap["wishlist"] ?? []) | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| containsKey("address") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| fromMap(document.get("address") | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| toMap() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| toMap() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| saveUserData() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| set(toMap() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| updateUserData() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| update(toMap() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| setAddress(Address address) | lib/models\users\users.dart | common | Sets the user's address and saves the updated user data to Firestore. |
| saveUserData() | lib/models\users\users.dart | common | Função/método em lib/models\users\users.dart |
| UserManager | lib/models\users\users_manager.dart | class | Classe presente em lib/models\users\users_manager.dart |
| UserManager() | lib/models\users\users_manager.dart | common | Constructor |
| setLanguageCode('pt-BR') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| initializeUser() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| loading(bool value) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| notifyListeners() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| editingCategories(bool value) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| notifyListeners() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| loadingFace(bool value) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| notifyListeners() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| loadingGoogle(bool value) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| notifyListeners() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| signOut(BuildContext context) | lib/models\users\users_manager.dart | common | Signs out the current user. |
| signOut() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| notifyListeners() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| updateUser(null) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| _loadCurrentUser({BuildContext? context, User? user}) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("users") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc(currentUser.uid) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| fromDocument(docUsers) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("admins") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc(users?.id) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| updateUser(users?.id) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| notifyListeners() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| reportNoFatalErrorToCrashlytics(
        error: "$error",
        stackTrace: StackTrace.current,
        information: "Erro na Classe: UserManager no método _loadCurrentUser() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| MonitoringLogger() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| logError('Erro ao carregar CurrentUser: $error') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| createAuxAndAdminsIfNotExists({required bool firstStart}) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| MonitoringLogger() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| logInfo('Info: Verifier createAuxAndAdminsIfNotExists') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("admins") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| limit(1) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("users") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("admins") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc(users!.id) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| set({"user": users!.id}) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("aux") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc("delivery") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| set(Delivery() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| toMap() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("aux") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc("orderCounter") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| set({"current": 1}) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| verifyEmailWithCode(BuildContext context, String oobCode) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| checkActionCode(oobCode) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| applyActionCode(oobCode) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| of(context) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| showSnackBar(
          const SnackBar(content: Text('E-mail verificado com sucesso!') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| debugPrint('Erro ao verificar e-mail: $e') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| sendPasswordResetEmailRequest({
    required String email,
    required VoidCallback onSuccess,
    required Function(String) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| sendPasswordResetEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: AppConfigKey.linkRecoverPasswordInWeb,
          handleCodeInApp: false,
          iOSBundleId: null,
          androidPackageName: null,
          androidInstallApp: false,
        ) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onSuccess() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onFail(e.message ?? "Erro desconhecido") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onFail("Erro inesperado: $e") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| confirmNewPassword({
    required String oobCode,
    required String newPassword,
    required VoidCallback onSuccess,
    required Function(String) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| confirmPasswordReset(code: oobCode, newPassword: newPassword) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onSuccess() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onFail(e.message ?? "Erro desconhecido") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onFail("Erro inesperado: $e") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| initializeUser({BuildContext? context}) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("users") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc(currentUser.uid) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| fromDocument(docUsers) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| notifyListeners() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| debugPrint('Erro ao inicializar usuário: $error') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| signInWithEmailAndPassword({
    required Users users,
    required Function onFail,
    required Function onSuccess,
    BuildContext? context,
  }) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| startTrace('sign-in-email', shouldStart: true) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| signInWithEmailAndPassword(email: users.email, password: users.password!) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| _loadCurrentUser(user: result.user, context: context) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onSuccess() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onFail(getErrorString(error.code) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| stopTrace('sign-in-email') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| singUpWithEmailAndPassword({
    required Users users,
    required Function onFail,
    required Function onSuccess,
    BuildContext? context,
  }) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| startTrace('sing-up-email', shouldStart: true) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| createUserWithEmailAndPassword(email: users.email, password: users.password!) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| saveUserData() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| _updateMonthlyNewUsers() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| updateUser(users.id) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onSuccess() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| onFail(getErrorString(error.code) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| stopTrace('sing-up-email') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| loginOrSingUpWithFacebook({
    required Function? onFail,
    required Function? onSuccess,
    BuildContext? context,
  }) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| startTrace('login-facebook', shouldStart: true) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| webAndDesktopInitialize(
          appId: Config.facebookAppId,
          cookie: true,
          xfbml: true,
          version: "v17.0",
        ) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| login() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| credential(accessToken.tokenString) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| signInWithCredential(credential) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("users") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc(user.uid) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| fromDocument(doc) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| updateUserData() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| Users(
                email: user.email ?? "",
                userName: user.displayName,
                id: user.uid,
                phoneNumber: user.phoneNumber ?? "",
                userPhotoURL: user.photoURL ?? "",
              ) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| saveUserData() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| _updateMonthlyNewUsers() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| updateUser(users?.id) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| call() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| getErrorString(error.code) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| stopTrace('login-facebook') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| loginOrSingUpWithGoogle({
    required Function? onFail,
    required Function? onSuccess,
    BuildContext? context,
  }) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| startTrace('login-google', shouldStart: true) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| GoogleAuthProvider() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| addScope('https://www.googleapis.com/auth/contacts.readonly') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| setCustomParameters({'login_hint': 'user@example.com'}) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| signInWithRedirect(provider) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| initialize() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| authenticate() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.idToken,
      ) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| signInWithCredential(credential) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection("users") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc(user.uid) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| fromDocument(doc) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| updateUserData() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| Users(
            email: user.email ?? "",
            userName: user.displayName,
            id: user.uid,
            phoneNumber: user.phoneNumber ?? "",
            userPhotoURL: user.photoURL ?? "",
          ) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| saveUserData() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| _updateMonthlyNewUsers() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| updateUser(users?.id) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| call() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| call("Erro ao autenticar usuário.") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| call(getErrorString(error.code) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| call("Erro inesperado: $e") | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| PerformanceMonitoring() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| stopTrace('login-google') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| _updateMonthlyNewUsers() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| now() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| toString() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| padLeft(2, '0') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection('aux') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc('NewUsers') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| collection('monthly') | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| doc(monthKey) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| get() | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| update({'count': FieldValue.increment(1) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| set({'count': 1}) | lib/models\users\users_manager.dart | common | Função/método em lib/models\users\users_manager.dart |
| provides | lib/models\who_we_are\who_we_are_manager.dart | class | Classe presente em lib/models\who_we_are\who_we_are_manager.dart |
| WhoWeAreManager | lib/models\who_we_are\who_we_are_manager.dart | class | Classe presente em lib/models\who_we_are\who_we_are_manager.dart |
| WhoWeAreManager({
    this.footerDescription,
    this.topDescription,
  }) | lib/models\who_we_are\who_we_are_manager.dart | common | Constructs a WhoWeAreManager instance with optional initial descriptions. |
| _subscribeToDescriptions() | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| loading(bool value) | lib/models\who_we_are\who_we_are_manager.dart | common | Sets the loading state and notifies listeners of changes. |
| notifyListeners() | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| _subscribeToDescriptions() | lib/models\who_we_are\who_we_are_manager.dart | common | Subscribes to real-time updates of descriptions from Firestore. |
| collection("whoweare") | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| doc("descriptions") | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| snapshots() | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| listen((DocumentSnapshot doc) | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| notifyListeners() | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| saveDescriptions() | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| collection("whoweare") | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| doc("descriptions") | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
| set(data) | lib/models\who_we_are\who_we_are_manager.dart | common | Função/método em lib/models\who_we_are\who_we_are_manager.dart |
