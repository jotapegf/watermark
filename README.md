# Watermark
Um aplicativo em Flutter que grava um vídeo de 10 segundos (com imagem e áudio) a partir da câmera, adiciona uma marca d'água a ele e o reproduz.

## Planejamento e Desenvolvimento
Inicialmente, fiz um brainstorm para organizar o aplicativo. Defini a aparência da homepage, o número de botões, textos, e outros elementos da interface. Esbocei no papel a interface de usuário (UI) que seria programada.

Em seguida, pensei que seria interessante permitir ao usuário escolher a marca d'água a ser aplicada no vídeo. Para isso, utilizei o plugin `image_picker` do Flutter. Optei por esse plugin devido à familiaridade que já tinha com ele. Após o usuário selecionar a imagem da galeria, ela é exibida como um "preview" em um formato circular.

O próximo passo foi implementar a funcionalidade de gravação de vídeo. A ideia é que o usuário escolha a marca d'água primeiro e, em seguida, grave o vídeo. O usuário também pode visualizar o vídeo gravado e decidir se deseja aplicar a marca d'água ou gravar outro vídeo.

Ao clicar no botão "Gravar Vídeo", a câmera do celular é aberta, e o vídeo é gravado. Após a gravação, o vídeo é reproduzido no aplicativo. Foram adicionadas opções de pausar, dar play e reiniciar o vídeo. Para isso, utilizei os pacotes `image_picker` para a gravação e `video_player` para a reprodução do vídeo. 

Escolhi o `image_picker` por já estar sendo usado no projeto e por oferecer suporte à gravação de vídeos. O `video_player` foi escolhido por ser mantido oficialmente pela equipe do Flutter e ser o mais bem avaliado na categoria, de acordo com o site pub.dev.

## Próximos Passos
O próximo passo é implementar um botão que processe o vídeo gravado com a marca d'água escolhida. No entanto, estou enfrentando dificuldades ao usar pacotes que dependem do FFmpeg. Todos que tentei até agora resultaram no seguinte erro:

**"A problem occurred configuring project ':flutter_ffmpeg'.
> Could not create an instance of type com.android.build.api.variant.impl.LibraryVariantBuilderImpl"**

Para o processamento do vídeo, encontrei um pacote simples e eficaz chamado `video_watermark` (versão ^1.0.5), que utiliza o FFmpeg para processar o vídeo. Apesar de sua implementação ser simples e rápida, ainda não consegui resolver os problemas relacionados ao uso do FFmpeg, conforme descrito acima. Continuo buscando soluções.
