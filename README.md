# Watermark
Um aplicativo em Flutter que grava um vídeo de 10 segundos (com imagem e áudio) a partir da câmera, adiciona uma marca d'água a ele e o reproduz.

## 0. Planejamento inicial
Inicialmente, fiz um brainstorm para organizar a ideia e o fluxo do uso do aplicativo. Defini a aparência da homepage, o número de botões, textos, e outros elementos da interface. Esbocei no papel a interface de usuário (UI) que seria programada. Estimei que, para esse planejamento, precisaria de 1 a 2 horas para planejar toda a aparência da interface e a usabilidade geral do aplicativo. De fato, o planejamente durou aproximadamente uma hora, visto que a ideia é simples e direta. No entanto, veremos que mais adiante, no desenvolvimento, fiz mudanças nesse planejamento, para melhorar a usabilidade do aplicativo. 

### 1. Escolha da imagem para usar como marca d'água
Em seguida, pensei que seria interessante permitir ao usuário escolher a marca d'água a ser aplicada no vídeo. Para isso, utilizei o plugin `image_picker: ^1.1.2` do Flutter. Optei por esse plugin devido à familiaridade que já tinha com ele. Após o usuário selecionar a imagem da galeria, ela é exibida como um "preview" em um formato circular no centro superior da tela. Como já sabia utilizar essas ferramentas, parti para a implementação, que durou aproximadamente 2 horas.

### 2. Gravação do vídeo
O próximo passo foi implementar a funcionalidade de gravação de vídeo. A ideia é que o usuário escolha a marca d'água primeiro e, em seguida, grave o vídeo. O usuário também poderá visualizar o vídeo gravado para decidir se deseja aplicar a marca d'água naquele vídeo ou gravar outro vídeo. Essa etapa não foi tão linear e rápida como as outras, pois nunca tinha implementado essas funcionalidades antes. Com a ideia em mente, parti para pesquisa, busquei vídeos no youtube de como acessar a camera e gravar vídeos em um app Flutter, pesquisei os pacotes disponíveis no pub.dev, visitei alguns repositórios no github que implementavam essa funcionalidade que queria, etc. No final, acabei implementando com a ajuda de um tutorial no youtube, juntamente com a utilização da documentação oficial do pacote e assistência de IAs generativas. Novamente, utilizei o `image_picker: ^1.1.2`. Essa etapa, por incluir muita pesquisa e alguns bugs indesejados, durou 2 dias. Ao clicar no botão "Gravar Vídeo", a câmera do celular é aberta, e o vídeo é gravado. Após a gravação, o vídeo é reproduzido no aplicativo. Foram adicionadas opções de pausar, dar play e reiniciar o vídeo, todas com apenas um toque no vídeo. Para a reprodução/visualização do vídeo, utilizei o pacote `video_player: ^2.9.1`, que foi escolhido por ser o principal usado para essa finalidade, e por ser criado e mantido pela equipe oficial do Flutter.   

Vale citar também que, em paralelo ao desenvolvimento planejado, eu usei meu tempo livre para pesquisar a parte mais crítica do projeto: o processamento do vídeo com a foto. Criei um projeto local na minha máquina só pra ir pesquisando e usando as ideias que achava. Enfrentei diversos desafios, que serão citados a seguir.  
Além disso, nesse momento, eu estava escrevendo tudo no arquivo **main.dart**, e o código estava começando a ficar grande e confuso. Por isso, separei os códigos em arquivos diferentes, melhorando sua modularização e deixando a navegação, isolação de funcionalides e widgets muito melhor.  

### 3. Processamento do vídeo com a imagem selecionada
Após ter criado um seletor de imagem, um gravador de vídeo e suas respectivas visualizações, chegou a hora de adicionar um botão para processar o vídeo gravado com a imagem selecionada. Essa etapa foi a mais desafiante do projeto, pois, no começo eu encontrei o pacote `video_watermark: ^1.0.5` no pub.dev. Esse pacote seria perfeito para o que eu queria, olhei sua documentação e sua implementação me pareceu trivial. No entanto, ao tentar implementar a funcionalidade em questão com esse pacote, o seguite erro SEMPRE aparecia:  

**"A problem occurred configuring project ':flutter_ffmpeg'.
> Could not create an instance of type com.android.build.api.variant.impl.LibraryVariantBuilderImpl"**.

Procurei inúmeras soluções para esse erro. Não encontrei nada que resolvesse na internet. Após uma pesquisa a fundo, descobri que o pacote em questão (video_watermark) usa uma versão antiga e descontinuada do FFMPEG, que não funciona mais com o Android Gradle Plugin 8 (AGP8), desse modo, tive que abandonar esse pacote e procurar outra solução, que não seria tão fácil e pronta.  
Após isso, ja sabia que o pacote que queria usar e não consegui era apenas uma simplificação de uso dos pacotes de FFMPEG do fluter. Ao pesquisar mais, encontrei o pacote `ffmpeg_kit_flutter: ^6.0.3`, o mais popular para processamento de vídeo, e decidi usá-lo. Não foi tão simples, pois não tinha familiaridade com FFMPEG.  
Novamente, caí em um erro parecido com o citado anteriormente, mas, dessa vez, descobri que era por conta do **minSdkVersion** do Flutter, que refere-se à versão mínima do Android SDK (Android Software Development Kit) que o aplicativo suporta.  

Com a ajuda da documentação e de IAs generativas, finalmente consegui fazer o processamento correto do vídeo com a imagem.   

Desde o começo eu sabia que essa seria a parte mais complicada e crítica do projeto, então estimei que levaria de 1 a 2 dias para a implementação. No entanto, com os problemas encontrados no caminho, lá se foram 3 longos dias de muitos desafios. O que foi ótimo, pois aprendi a configurar e entendi muito de qual é o papel dos arquivos **pubspec.yaml**, **build.gradle**, etc.  

Ao fim, da terceira parte, já tinhamos basicamente um aplicativo com as funcionalidades que queriamos. No entanto, ainda faltava alguns polimentos, correções de bugs e adaptações que eu gostaria de fazer.

## Próximos Passos
- Corrigir o bug que faz o vídeo sumir ao escolher uma nova imagem

- Corrigir o bug que faz a camera ficar "de ponta cabeça" ao gravar com a câmera frontal

- Corrigir a visualização do vídeo processado (um leve desalinhamento na tela)
