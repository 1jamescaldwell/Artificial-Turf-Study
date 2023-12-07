%% FieldTurf Shear Force vs Displacement
% University of Virginia 
% Ben Koerber, James Caldwell

% 12/4/23

%% Generate Shear Force vs. Displacement Plots
% This code loops through the run log and generates comparison plots of
% shear vs displacement. The comparisons variable is a n x 11 list, with
% the columns representing the 11 types of turf tested. Make 1s and 0s for
% the types of comparisons you want to make.
% If a comparison is added, add lines to the legend section 

% Currently, this plots the comparisons for 20mm Z displacement for turf only

% These two .mats should be loaded:
%     load('\\cab-fs07.mae.virginia.edu\NewData\FieldTurf\2023-FieldTurf\1Data-ANALYZED\FT_Data.mat') 
%     load('Distinguishable_Colors_Colorset.mat')

close all
save = 0; % Make 1 to turn save on, 0 to not save plot figures

% Enter here the desired displacement tests you wish to compare 
displacement = 20;
% displacement = 23.5;

% These are the comparisons generated
% Add lines to this to make more comparisons. If you do, add legend entries
% in the Legend section
comparisons = ...
[1 1 1 1 1 1 1 1 1 1 1 % All
0 0 0 0 0 0 0 0 1 1 1 % Comparing carpet types 9, 10, 11
0 0 0 0 0 1 0 1 0 0 0 % Comparing carpet types 6, 8
0 0 0 1 1 0 0 0 0 0 0 % 4, 5
1 1 1 0 0 0 0 0 0 0 0 % 1, 2, 3
0 0 0 0 0 0 1 1 0 0 0 % 7, 8
0 0 0 1 0 1 0 0 0 0 0 % 4, 6
1 0 0 1 0 0 0 0 1 0 0 % 1, 4, 9
0 1 0 0 0 0 0 0 0 1 0 % 2, 10
0 0 1 0 0 1 0 0 0 0 1 % 3, 6, 11
0 0 0 1 0 0 1 0 0 0 0 % 4, 7
0 0 0 0 0 0 1 0 0 1 0 % 7, 10
1 0 0 0 0 1 0 0 0 0 0 % 1, 6
0 0 1 1 1 0 0 0 0 0 0]; % 3, 4, 5 %Comparing the completed with stitch testing so far

% Loops through the comparisons variable and makes a plot for each type
for compIdx = 1:size(comparisons, 1) 

    clearvars -except Colorset FT_Data compIdx comparisons save displacement
        % The handle variables, h1, h2, h3, especially need to be cleared for the next graph to work
    
    %% Initialize Figures
    f2 = figure('Position',[100 100 1200 600]);
    xlabel('X Displacement (mm)','FontSize',18)
    ylabel('Shear Force (N)','FontSize',18)
    title('Shear Force vs. Displacement','FontSize',18)
    set(gca,"FontSize",18)
    subtitle(strcat('Same input between tests: ',{' '},num2str(displacement),'mm compression, 100mm shear'),'FontSize',12)
    grid on
    grid minor
    xlim([0, 70]);
    ylim([0, 5000]);
    hold on
    
    % Adds a text box nothing that dashed lines are with stitch, solid are across stitch
    noteText = ' --- Across stitch - - - With stitch';
    annotation('textbox', [0.6, 0.15, .14, .1], 'String', noteText, 'HorizontalAlignment', 'center', 'EdgeColor', 'k','FontSize',16);
    
    %Loop through the run log
    for k = length(FT_Data):-1:1 % Loop through the run log in reverse.. quick solution to having all the legend lines be solid (across stitch testing) rather than dashed (with stitch testing), since the with stitch testing was completed after the across stitch
        
        [minZdisp,~] = min(FT_Data(k).SV_DZ);
        
        dispLower = -displacement - .5;
        dispUpper = -displacement + .5;
        
        % We want tests that were the desired Z displacement and not: grass or sideways tests
        if (dispUpper > minZdisp) && (minZdisp > dispLower) && ~strcmp(FT_Data(k).TurfType,'Grass') % && ~contains(FT_Data(k).SimVID,'Sideways')
        
            [~,dataLength] = min(FT_Data(k).LC_FX);
            lineWidth = 1;
                
            if contains(FT_Data(k).SimVID,'Sideways') % With Stitch tests
                lineStyle = '--';
                x = FT_Data(k).SV_DY(1:dataLength);
            else % Across stitch tests
                lineStyle = '-';
                x = -FT_Data(k).SV_DX(1:dataLength);
            end
        
        
            %% Plot
            if FT_Data(k).TurfType == 1 && comparisons(compIdx,1)
                LineColor = Colorset(1,:);
                h1 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 2 && comparisons(compIdx,2)
                LineColor = Colorset(2,:);
                h2 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 3 && comparisons(compIdx,3)
                LineColor = Colorset(3,:);
                h3 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 4 && comparisons(compIdx,4)
                LineColor = Colorset(4,:);
                h4 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 5 && comparisons(compIdx,5)
                LineColor = Colorset(5,:);
                h5 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 6 && comparisons(compIdx,6)
                LineColor = Colorset(6,:);
                h6 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 7 && comparisons(compIdx,7)
                LineColor = Colorset(7,:);
                h7 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 8  && comparisons(compIdx,8)
                LineColor = Colorset(8,:);
                h8 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 9  && comparisons(compIdx,9)
                LineColor = Colorset(9,:);
                h9 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 10  && comparisons(compIdx,10)
                LineColor = Colorset(10,:);
                h10 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            elseif FT_Data(k).TurfType == 11  && comparisons(compIdx,11)
                LineColor = Colorset(11,:);
                h11 = plot(x,-FT_Data(k).LC_FX(1:dataLength),'Color',LineColor,'LineWidth',lineWidth,'LineStyle',lineStyle);
            end
        end
    
    
    end
    %% Legends
    
    legendLocation = 'southeast';
    
    figure(f2)
    
    % There has to be a better way to do this, but matlab doesn't allow grouping handles of multiple lines together so maybe there isn't
    if comparisons(compIdx,:) == [1 1 1 1 1 1 1 1 1 1 1] % All
        savename = 'all';
        L1 = legend([h1(1) h2(1) h3(1) h4(1) h5(1) h6(1) h7(1) h8(1) h9(1) h10(1) h11(1)],'Turf Type 1','Turf Type 2','Turf Type 3','Turf Type 4','Turf Type 5','Turf Type 6','Turf Type 7','Turf Type 8','Turf Type 9','Turf Type 10','Turf Type 11', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 0 0 0 0 0 0 1 1 1] % 9, 10, 11
        savename = '9_10_11';
        L1 = legend([h9(1) h10(1) h11(1)],'Turf Type 9','Turf Type 10','Turf Type 11', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 0 0 0 1 0 1 0 0 0] % 6, 8 
        savename = '6_8';
        L1 = legend([h6(1) h8(1)],'Turf Type 6','Turf Type 8', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 0 1 1 0 0 0 0 0 0] % 4, 5
        savename = '4_5';
        L1 = legend([h4(1) h5(1)],'Turf Type 4','Turf Type 5', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [1 1 1 0 0 0 0 0 0 0 0] % 1, 2, 3
        savename = '1_2_3';
        L1 = legend([h1(1) h2(1) h3(1)],'Turf Type 1','Turf Type 2','Turf Type 3', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 0 0 0 0 1 1 0 0 0] % 7, 8
        savename = '7_8';
        L1 = legend([h7(1) h8(1)],'Turf Type 7','Turf Type 8', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 0 1 0 1 0 0 0 0 0] % 4, 6
        savename = '4_6';
        L1 = legend([h4(1) h6(1)],'Turf Type 4','Turf Type 6', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [1 0 0 1 0 0 0 0 1 0 0] % 1, 4, 9
        savename = '1_4_9';
        L1 = legend([h1(1) h4(1) h9(1)],'Turf Type 1','Turf Type 4','Turf Type 9', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 1 0 0 0 0 0 0 0 1 0] % 2, 10
        savename = '2_10';
        L1 = legend([h2(1) h10(1)],'Turf Type 2','Turf Type 10', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 1 0 0 1 0 0 0 0 1] % 3, 6, 11
        savename = '3_6_11';
        L1 = legend([h3(1) h6(1) h11(1)],'Turf Type 3','Turf Type 6','Turf Type 11', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 0 1 0 0 1 0 0 0 0] % 4, 7
        savename = '4_7';
        L1 = legend([h4(1) h7(1)],'Turf Type 4','Turf Type 7', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 0 0 0 0 1 0 0 1 0] % 7, 10
        savename = '7_10';
        L1 = legend([h7(1) h10(1)],'Turf Type 7','Turf Type 10', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [1 0 0 0 0 1 0 0 0 0 0] % 1, 6
        savename = '1_6';
        L1 = legend([h1(1) h6(1)],'Turf Type 1','Turf Type 6', 'Location',legendLocation);
    elseif comparisons(compIdx,:) == [0 0 1 1 1 0 0 0 0 0 0] % 3, 4, 5
        savename = '3_4_5';
        L1 = legend([h3(1) h4(1) h5(1)],'Turf Type 3','Turf Type 4', 'Turf Type 5','Location',legendLocation);
    % If you add a new comparison, add a new elseif statement here
    end
    
    
    %% Save
    
    if save == 1
        fig_name = strcat('\\cab-fs07.mae.virginia.edu\NewData\FieldTurf\2023-FieldTurf\1Data-ANALYZED\ShearVsDisp\',num2str(displacement),'mm\',savename,'_Carpets.fig');
        png_name = strrep(fig_name,'fig','png');
        saveas(gcf,fig_name);
        saveas(gcf,png_name);
    end 

end
