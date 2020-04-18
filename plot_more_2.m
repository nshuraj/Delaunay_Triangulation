function [] = plot_more(cx,cy,p)

c_x = [cx; p(1,:)'];
c_y = [cy; p(2,:)'];

n = size(c_x,1);

for i = 1:n-1
    
    c_x = circshift(c_x,1);
    c_y = circshift(c_y,1);
    
    [r p_x p_y] = draw_circle(c_x,c_y);    
    
end

