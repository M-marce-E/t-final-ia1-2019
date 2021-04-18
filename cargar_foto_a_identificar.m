function caracts_foto = cargar_foto_a_identificar(imagen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  cargar_foto_a_identificar                                            %
% Parametros de Entrada:                                                 %
%   imagen - foto de la pieza que se va a clasificar                     %
% Parametros de Salida:                                                  %
%   caracts_foto - array [2x1] con la excentricidad y el área de la fig  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Se extrae el canal verde de la foto para eliminar el fondo verdoso
    greenChannel= imagen(:,:,2);
    % Se muestra en la pantalla el canal verde de la imagen
    figure;
    imshow(greenChannel);
    title('Canal Verde');
    
    % Se rellenan las discontinuidades del negativo de la imagen
    lleno= imfill(imcomplement(greenChannel), 'holes');
    % Se muestra la figura del negativo de la imagen
    figure;
    imshow(lleno);
    title('Negativo sin huecos');
    
    % La imagen inversa se vuelve imagen binaria (monocromática)
    BW= imbinarize(lleno);
    % Se muestra en la pantalla la imagen binaria
    figure;
    imshow(BW); 
    title ('Imagen Monocromática');
    
    % Se extraen características de la foto
    cc= regionprops(BW, 'Eccentricity', 'Area');
    % Mide la excentricidad de la forma circular y se
    % guarda en el array con las características extraídas
    caracts_foto(1,1)= cc.Eccentricity;
    % Se calcula el área de la región y se registra dicha característica
    caracts_foto(2,1)= cc.Area;
    
end