function agrupar_con_kmeans(dataBase, N, K, iteraciones)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  agrupar_con_kmeans                                                   %
% Parametros de Entrada:                                                 %
%   dataBase - array [2xN] con características del dataset               %
%   N - número total de fotos en la base de datos                        %
%   K - número de categorías ó clasificaciones                           %
%   iteraciones - número de iteraciones que realizará el método K-means  %
% Parametros de Salida:                                                  %
%   gráficas de dispersión del dataset con los centroides obtenidos      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    X= dataBase';
    % Toma K centroides aleatorios
    indC= randperm(N, K);
    for i = 1 : iteraciones
        ind= knnsearch(X(indC,:), X);
        % El centroide más cercano determina la categoría de cada punto
        for k = 1 : K
            indk= ind == k;
            meank= mean(X(indk,:));
            indC(k)= knnsearch(X, meank);
        end
        figure;
        hold all;
        % Se recalculan los centroides
        for k = 1 : K
            indk= find(ind == k);
            % Muestra el diagrama de dispersión de las características para
            % cada iteración
            plot(X(indk,1), X(indk,2), '.', 'MarkerSize', 17);
        end
        plot(X(indC,1), X(indC,2), 'or', 'MarkerSize',10, 'MarkerFaceColor','r');
        xlabel('excentricidad');
        ylabel('área');
        title(['K-means Iteración N°' num2str(i)]);
        grid on;
    end
    
end