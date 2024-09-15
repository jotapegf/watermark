# Watermark!
Um aplicativo em Flutter que grava um vídeo de 10 segundos (com imagem e áudio) a partir da câmera, adiciona uma marca d'água a ele e o reproduz.

## Planejamento e confecção
Primeiramente, fiz um brainstorm de como será a organização do aplicativo, isto é, como será a aparência da homepage, quantos botões, textos terá, etc... Desenhei em um papel como será a UI que vou programar.  

Após isso, pensei que seria interessante para o usuário poder escolher qual será a marca d'agua a ser colocada no vídeo. Pra isso, utilizei o image_picker plugin for Flutter. Escolhi esse plugin, pois já tinha trabalhado 
com ele e já tinha familiaridade com sua usabilidade. Após escolhermos a imagem da galeria, ela é exibida em um círculo, como se fosse uma 'preview'.  

O próximo passo, foi adicionar a funcionalidade de gravar o vídeo em si. A ideia é que primeiro escolhamos a marca d'água, depois gravamos o vídeo.  
É interessante que o usuário possa ver o vídeo gravado para decidir se quer adicionar a marca d'água naquele vídeo, ou gravar outro.  
Ao clicar no botão 'Gravar vídeo' a camera do celular é aberta, e podemos gravar o vídeo. após concluir a gravação, o vídeo é reproduzido no aplicativo.   
Foi adiocionado a opção de pausar, dar play, e reiniciar o vídeo no app.  
Para essa etapa, foi utilizado os pacotes image_picker para gravar o vídeo, e o pacote video_player para reproduzir o vídeo.  
Escolhi novamente o image_picker, pois ele já estava sendo utilizado no projeto, já tinha familiaridade com ele, e pesquisando, descobri que ele também tinha funcionalidades para gravação de vídeo.  
Já o video_player foi escolhido pois é feito oficialmente pela equipe do Flutter e é o mais bem avaliado da categoria no site pub.dev.

O próximo passo será implementar um botão para processar o vídeo gravado com a marca d'água escolhida. No entanto, venho enfrentando muitas dificuldades ao usar pacotes que usam qualquer subpacote com ffmpeg. Todos que utilizei não deram certo. e o erro é o mesmo: A problem occurred configuring project ':flutter_ffmpeg'.
> Could not create an instance of type com.android.build.api.variant.impl.LibraryVariantBuilderImpl
Para o processamento do vídeo, encontrei um pacote simples e eficaz para o objetivo do projeto, no entando, ele utiliza ffmpeg para o processamento do vídeo.
O pacote em questão é o video_watermark: ^1.0.5. Sua implementação e usabilidade se mostrou bem simples e rápida.
Até o momento, não consegui avanços no que diz respeito a usar pacotes com ffmpeg para o processamento do vídeo, por conta do erro aqui relatado. Sigo pesquisando e procurando soluções.

