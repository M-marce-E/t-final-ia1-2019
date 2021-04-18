function moda = clasificar_con_knn(dataBase, categoria, caracts_foto, k_vecinos_proximos)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  clasificar_con_knn                                                   %
% Parametros de Entrada:                                                 %
%   dataBase - array [2xN] de características (excent, área) del dataset %
%   categoria - vector [1xN] con la categoría (de 1 a 4) de cada foto    %
%   caracts_foto - array [2x1] de características de la foto clasificada %
%   k_vecinos_proximos - nro de vecinos cercanos para clasificar c/punto %
% Parametros de Salida:                                                  %
%   moda - clase de la foto clasificada, que más se repite entre vecinos %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calcula la distancia euclidiana a cada uno de los puntos
    [xx,yy]=meshgrid(dataBase(1,:)-caracts_foto(1,1), dataBase(2,:)-caracts_foto(2,1));
    distancia= sqrt(xx.*xx + yy.*yy);
    
    % Se ordenan las categorías con la distancia desde cada punto
    [~,ix] = sort(diag(distancia));
    categoria = categoria(ix);
    
    % El valor k NO debe ser un múltiplo de número de categorías
    % (k): Cantidad de puntos vecinos cercanos 
    for i = 1 : k_vecinos_proximos
        for j = 1 : i
            etiqueta= categoria(1:i);
            moda= mode(etiqueta');
        end
    end
    
end