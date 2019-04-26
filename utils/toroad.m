street_dis_low = floor(y(c));
street_dis_high = ceil(y(c));
ave_dis_low = floor(x(c));
ave_dis_high = ceil(x(c));

% check which street or avenue that is closest to the car
if x(c) < 9 | x(c) > 13
    if abs(y(c) - street_dis_low) < 0.01
        if rand < pchangepath | abs(x(c) - xd(c)) < 0.5 | abs(y(c) - yd(c)) < 0.5
            h = street_dis_low;
            direction = odd(h)-even(h); 
            if direction > 0
                z = ave_dis_high;
            else
                z = ave_dis_low;
            end
            if fc(z,h,2) == 0
                onroad(c) = 1;
                fc(z,h,2)=c;
                lc(z,h,2)=c;
                nc(c)=0;    
                offoverpass = 1;
                y(c) = street_dis_low;
            else
                if direction > 0
                    if x(fc(z,h,2)) < x(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,2);
                        fc(z,h,2) = c;
                        offoverpass = 1;
                        y(c) = street_dis_low;
                    elseif x(lc(z,h,2)) > x(c)
                        onroad(c) = 1;
                        nc(lc(z,h,2))=c;
                        lc(z,h,2)=c;
                        nc(c)=0;  
                        offoverpass = 1;
                        y(c) = street_dis_low;
                    end
                else
                    if x(fc(z,h,2)) > x(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,2);
                        fc(z,h,2) = c;
                        offoverpass = 1;
                        y(c) = street_dis_low;
                    elseif x(lc(z,h,2)) < x(c)
                        onroad(c) = 1;
                        nc(lc(z,h,2))=c;
                        lc(z,h,2)=c;
                        nc(c)=0;
                        offoverpass = 1;
                        y(c) = street_dis_low;
                    end
                end
            end     
        end
    elseif abs(street_dis_high - y(c)) < 0.01
        if rand < pchangepath | abs(x(c) - xd(c)) < 0.5 | abs(y(c) - yd(c)) < 0.5
            h = street_dis_high;
            direction = odd(h)-even(h); 
            if direction > 0
                z = ave_dis_high;
            else
                z = ave_dis_low;
            end
            if fc(z,h,2) == 0
                onroad(c) = 1;
                fc(z,h,2)=c;
                lc(z,h,2)=c;
                nc(c)=0;    
                offoverpass = 1;
                y(c) = street_dis_high;
            else
                if direction > 0
                    if x(fc(z,h,2)) < x(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,2);
                        fc(z,h,2) = c;
                        offoverpass = 1;
                        y(c) = street_dis_high;
                    elseif x(lc(z,h,2)) > x(c)
                        onroad(c) = 1;
                        nc(lc(z,h,2))=c;
                        lc(z,h,2)=c;
                        nc(c)=0;
                        offoverpass = 1;
                        y(c) = street_dis_high;
                    end
                else
                    if x(fc(z,h,2)) > x(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,2);
                        fc(z,h,2) = c;
                        offoverpass = 1;
                        y(c) = street_dis_high;
                    elseif x(lc(z,h,2)) < x(c)
                        onroad(c) = 1;
                        nc(lc(z,h,2))=c;
                        lc(z,h,2)=c;
                        nc(c)=0;
                        offoverpass = 1;
                        y(c) = street_dis_high;
                    end
                end
            end
        end
    elseif abs(x(c) - ave_dis_low) < 0.01
        if rand < pchangepath | abs(x(c) - xd(c)) < 0.5 | abs(y(c) - yd(c)) < 0.5
            z = ave_dis_low;
            direction = even(z) - odd(z); 
            if direction > 0
                h = street_dis_high;
            else
                h = street_dis_low;
            end
            if fc(z,h,1) == 0
                onroad(c) = 1;
                fc(z,h,1)=c;
                lc(z,h,1)=c;
                nc(c)=0;    
                offoverpass = 1;
                x(c) = ave_dis_low;
            else
                if direction > 0
                    if y(fc(z,h,1)) < y(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,1);
                        fc(z,h,1) = c;
                        offoverpass = 1;
                        x(c) = ave_dis_low;
                    elseif y(lc(z,h,1)) > y(c)
                        onroad(c) = 1;
                        nc(lc(z,h,1))=c;
                        lc(z,h,1)=c;
                        nc(c)=0;
                        offoverpass = 1;
                        x(c) = ave_dis_low;
                    end
                else
                    if y(fc(z,h,1)) > y(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,1);
                        fc(z,h,1) = c;
                        offoverpass = 1;
                        x(c) = ave_dis_low;
                    elseif y(lc(z,h,1)) < y(c)
                        onroad(c) = 1;
                        nc(lc(z,h,1))=c;
                        lc(z,h,1)=c;
                        nc(c)=0;
                        offoverpass = 1;
                        x(c) = ave_dis_low;
                    end
                end
            end
        end
    elseif abs(ave_dis_high - x(c)) < 0.01
        if rand < pchangepath | abs(x(c) - xd(c)) < 0.5 | abs(y(c) - yd(c)) < 0.5
            z = ave_dis_high;
            direction = even(z) - odd(z); 
            if direction > 0
                h = street_dis_high;
            else
                h = street_dis_low;
            end
            if fc(z,h,1) == 0
                onroad(c) = 1;
                fc(z,h,1)=c;
                lc(z,h,1)=c;
                nc(c)=0;    
                offoverpass = 1;
                x(c) = ave_dis_high;
            else
                if direction > 0
                    if y(fc(z,h,1)) < y(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,1);
                        fc(z,h,1) = c;
                        offoverpass = 1;
                        x(c) = ave_dis_high;
                    elseif y(lc(z,h,1)) > y(c)
                        onroad(c) = 1;
                        nc(lc(z,h,1))=c;
                        lc(z,h,1)=c;
                        nc(c)=0;
                        offoverpass = 1;
                        x(c) = ave_dis_high;
                    end
                else
                    if y(fc(z,h,1)) > y(c)
                        onroad(c) = 1;
                        nc(c) = fc(z,h,1);
                        fc(z,h,1) = c;
                        offoverpass = 1;
                        x(c) = ave_dis_high;
                    elseif y(lc(z,h,1)) < y(c)
                        onroad(c) = 1;
                        nc(lc(z,h,1))=c;
                        lc(z,h,1)=c;
                        nc(c)=0;
                        offoverpass = 1;
                        x(c) = ave_dis_high;
                    end
                end
            end
        end
    else
        ;
    end
end