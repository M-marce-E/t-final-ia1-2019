%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  "Trabajo Final Inteligencia Artificial I – año 2019"                 %
% Marcelo E Mellimaci (Leg 10764)                                        %
%                                                                        %
% Sistema de clasificación de piezas metálicas por visión artificial     %
% Agente que permite identificar tornillos, clavos, tuercas y arandelas  %
% Toma imágenes de las 4 categorías por separado como una base de datos  %
% Se usan los métodos K-means y K-nn para realizar la clasificación      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Antes de correr el script se eliminan variables globales y se
% limpia la pantalla
clc, clear, close all;

% Directorio dónde se encuentran las imágenes '.jpg' de base de datos
ruta_dataset= uigetdir("", 'Elija el directorio de las fotos del dataset:');
cd(ruta_dataset);
DataSet= imageDatastore(ruta_dataset, 'FileExtensions', {'.jpg'});
N= length(dir('*.jpg'));

% Se va al directorio del proyecto para leer los fuentes de las funciones
cd('/MATLAB Drive/MMellimaci/Proyecto_IA_1/');
% Se extraen características del dataset y se almacenan en dos arrays
[dataBase, categoria]= cargar_dataset(DataSet, N);
% Se muestra el diagrama de las características de las fotos del dataset
figure;
plot(dataBase(1,:), dataBase(2,:), '.', 'MarkerSize', 17);
xlabel('excentricidad');
ylabel('área');
title("Gráfico de dispersión del dataset");

% Carga la fotografía de la pieza a clasificar
[FileName,PathName] = uigetfile('*.jpg','Elija la foto de la pieza a clasificar:');
imagen= imread(strcat(PathName,FileName));
caracts_foto= cargar_foto_a_identificar(imagen);
% Muestra las características extratídas de la imagen a reconocer: 
% el área y la excentricidad de la forma redondeada 
disp('Excentricidad y Área de la imagen clasificada:');
disp(caracts_foto');

% Se agrupa en 4 grupos el dataBase con las características de las fotos
tic;
% answer= inputdlg({'Ingrese el nro de iteraciones del método K-means:'}, ...
%     'Número de iteracs para K-means:', [1 40], {'7'});
% iteraciones = str2double(answer{1});
iteraciones= input('Ingrese el Nro de Iteraciones para el método K-means:');
agrupar_con_kmeans(dataBase, N, 4, iteraciones);
disp("Tiempo de ejecución del algoritmo K-means:");
disp(toc);

% Se identifica la categoría de la foto a clasificar a través de KNN
tic;
% En KNN el nro de vecinos 'k' NO debe ser un múltiplo de nro de categorías
% answer= inputdlg({'Ingrese el valor K de vecinos próximos para K-nn:'}, ...
%     'K vecinos para el método K-nn:', [1 40], {'13'});
% k_vecinos_proximos = str2double(answer{1});
k_vecinos_proximos= input('Ingrese el valor K de vecinos próximos para K-nn:');
moda= clasificar_con_knn(dataBase, categoria, caracts_foto, k_vecinos_proximos);
% Se muestra el resultado de la categorización, además de un mensaje de voz
disp('La pieza clasificada es:');
if (moda == 1)
    disp('    una ARANDELA');
    disp("Tiempo de ejecución del algoritmo K-NN:");
    disp(toc);
    f = msgbox('La pieza clasificada es: una ARANDELA','Arandela');
    % Se escucha la frase "La pieza clasificada es una arandela"
    [y, Fs] = audioread('/MATLAB Drive/MMellimaci/Proyecto_IA_1/voces/arandela.wav');
    player=audioplayer(y,Fs);
    play(player);
elseif(moda == 2)
    disp('    un CLAVO');
    disp("Tiempo de ejecución del algoritmo K-NN:");
    disp(toc);
    f = msgbox('La pieza clasificada es: un CLAVO','Clavo');
    % Se escucha la frase "La pieza clasificada es un clavo"
    [y, Fs] = audioread('/MATLAB Drive/MMellimaci/Proyecto_IA_1/voces/clavo.wav');
    player=audioplayer(y,Fs);
    play(player);
elseif(moda == 3)
    disp('    un TORNILLO');
    disp("Tiempo de ejecución del algoritmo K-NN:");
    disp(toc);
    f = msgbox('La pieza clasificada es: un TORNILLO','Tornillo');
    % Se escucha la frase "La pieza clasificada es un tornillo"
    [y, Fs] = audioread('/MATLAB Drive/MMellimaci/Proyecto_IA_1/voces/tornillo.wav');
    player=audioplayer(y,Fs);
    play(player);
elseif(moda == 4)
    disp('    una TUERCA');
    disp("Tiempo de ejecución del algoritmo K-NN:");
    disp(toc);
    f = msgbox('La pieza clasificada es: una TUERCA','Tuerca');
    % Se escucha la frase "La pieza clasificada es una tuerca"
    [y, Fs] = audioread('/MATLAB Drive/MMellimaci/Proyecto_IA_1/voces/tuerca.wav');
    player=audioplayer(y,Fs);
    play(player);
end