function change = decideoverpass(x,y,xd,yd,center,radius)

change = 0;
dist = sqrt((x - xd)^2 + (y - yd)^2);

% decide clockwise or counter-clockwise 
if mod(radius, 2) == 0
    if (x  > center)
        x_test = x + 0.05;
        if y > center
            y_test = y - sqrt(radius^2 - (center - x_test)^2);
        else
            y_test = y + sqrt(radius^2 - (center - x_test)^2);
        end
        newdist = sqrt((x_test - xd)^2 + (y_test - yd)^2);
        if newdist < dist
            change = 1;
        end
    else
        x_test = x + 0.05;
        if y > center
            y_test = y + sqrt(radius^2 - (center - x_test)^2);
        else
            y_test = y - sqrt(radius^2 - (center - x_test)^2);
        end
        newdist = sqrt((x_test - xd)^2 + (y_test - yd)^2);
        if newdist < dist
            change = 1;
        end
    end
else
    if (x  > center)
        x_test = x - 0.05;
        if y > center
            y_test = y + sqrt(radius^2 - (center - x_test)^2);
        else
            y_test = y - sqrt(radius^2 - (center - x_test)^2);
        end
        newdist = sqrt((x_test - xd)^2 + (y_test - yd)^2);
        if newdist < dist
            change = 1;
        end
    else
        x_test = x - 0.05;
        if y > center
            y_test = y - sqrt(radius^2 - (center - x_test)^2);
        else
            y_test = y + sqrt(radius^2 - (center - x_test)^2);
        end
        newdist = sqrt((x_test - xd)^2 + (y_test - yd)^2);
        if newdist < dist
            change = 1;
        end
    end
end
