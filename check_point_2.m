function [status] = check_point(p,r,p_x,p_y)

d = sqrt( (p_x-p(1))^2 + (p_y-p(2))^2 );

if d > r
    status = -1;
end

if d < r
    status = 1;
end

if d == r
    status = 0;
end

end

