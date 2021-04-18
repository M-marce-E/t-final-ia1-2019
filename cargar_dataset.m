function [dataBase, categoria] = cargar_dataset(DataSet, N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  cargar_dataset                                                       %
% Parametros de Entrada:                                                 %
%   DataSet - conjunto de imágenes (imageDatastore) del dataset          %
%   N - número total de fotos en la base de datos                        %
% Parametros de Salida:                                                  %
%   dataBase - array [2xN] con características (excen, área) del dataset %
%   categoria - vector [1xN] con la categoría (de 1 a 4) para cada foto  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    dataBase= zeros(2, N);
    categoria= zeros(1, N);
    i= 1;
    %Los índices en Matlab/Octave empiezan en 1
    while (hasdata(DataSet))
        % Carga las imágenes
        imagen= read(DataSet);
        
        % Separa el canal verde de cada imagen para eliminar el fondo
        greenChannel= imagen(:,:,2);
        % Se rellenan las discontinuidades del negativo de las imágenes
        lleno= imfill(imcomplement(greenChannel), 'holes');
        % La imagen inversa se vuelve imagen binaria (monocromática)
        BW= imbinarize(lleno);
        
        % Se extraen características de la imagen
        cc= regionprops(BW, 'Eccentricity', 'Area');
        % Mide la excentricidad de la forma redondeada y
        % se guarda en la matriz con características
        dataBase(1,i)= cc.Eccentricity;
        % Se calcula el área de la región y se registra dicha característica
        dataBase(2,i)= cc.Area;
        
        % Se clasifican las N fotos en 4 categorías diferentes
        %quedando N/4 fotografías en cada categoría
        if (i <= N/4)
            % Arandelas
            categoria(1,i)=1;
        elseif(i>N/4 && i<=2*N/4)
            % Clavos
            categoria(1,i)=2;
        elseif(i>2*N/4 && i<=3*N/4)
            % Tornillos
            categoria(1,i)=3;
        else
            % Tuercas
            categoria(1,i)=4;      
        end
        % Suma las posiciones para cada sección del arreglo
        i= i + 1;
    end
    
end