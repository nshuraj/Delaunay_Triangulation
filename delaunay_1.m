clear all;
n=input('Enter number of Vertices for Polygon :');
if n>4
    N=n+1;
    axis([0,50,0,50])
    hold on
    
    for pt=1:n
        IP=ginput(1);
        A(pt,:)=IP;
        plot(A(pt,1),A(pt,2),'-.b.','markersize',20);
        
        hold on;
        plot(A(:,1),A(:,2));
    end
    % plot(A(:,1),A(:,2))
    
    col=['r','b','g','y','m','c','k','y','m','c','k'];
    
    % mt=[];
    ck=1;
    
    for i=1:n
        for j=i+1:n
            for k=j+1:n
                %(1/m1)=n1
                x1=A(i,1); y1=A(i,2);
                x2=A(j,1); y2=A(j,2);
                x3=A(k,1); y3=A(k,2);
                p1=[x1,y1;x2,y2;x3,y3;x1,y1];
                n1=(x1-x2)/(y2-y1);
                %disp(n1);
                
                
                n2=(x2-x3)/(y3-y2);
                %disp(n2);
                
                r1=(x1+x2)/2;
                r2=(x2+x3)/2;
                
                t1=(y1+y2)/2;
                t2=(y2+y3)/2;
                
                
                v1=(t1-(r1*n1));
                v2=(t2-(r2*n2));
                
                a=[-n1,1;
                    -n2,1];
                
                b=[v1;v2];
                
                p=inv(a)*b;
                
                C=[];
                
                rd=sqrt((p(2)-y1)^2+(p(1)-x1)^2);
                th=0:pi/100:2*pi;
                c1=rd*cos(th)+p(1);
                c2=rd*sin(th)+p(2);
                rh=0;
                %C=[C;c1,c2'];
                %plot(c1,c2);
                [in] = inpolygon(A(:,1),A(:,2),c1,c2);
                if sum(in)==0
                    
                    plot(p1(:,1),p1(:,2),'LineWidth',3);
                    plot(c1,c2,col(randi(9)));
                    rh=rh+1;
                    %fill(p1(:,1),p1(:,2),col(randi(9)))
                    hold on
                    mt(ck,:)=[i,j,k];
                    %        mt{ck}=[p1(:,1),p1(:,2)];
                    %        mt{ck}(4,:) = [];
                    
                    
                    
                    
                end
                
            end
            
        end
        ck=ck+1;
    end
    
%     disp(mt(3,:));
    %sz=size(mt,1)*size(mt,2)
    
    
     mt=mt';
     for fi=1:sz
         
            mk(fi,:)=A(mt(fi),:) ;
                
               
      
     end
        xlswrite('tri.xlsx',mk);
        mp=mt';
        xlswrite('tri2.xlsx',mp);
    
    
else
    axis([0,50,0,50])
    hold on
    for pt=1:n
        IP=ginput(1);
        A(pt,:)=IP;
        plot(A(pt,1),A(pt,2),'-.b.','MarkerSize',10);
        hold on;
        
    end
    A(n+1,:)=A(1,:)
    plot(A(:,1),A(:,2));
    Sq=[(A(1,1)),(A(1,2));
        (A(3,1)),(A(3,2))]
    plot(Sq(:,1),Sq(:,2),'LineWidth',3);
    %  for f=1:3
    %  fill(A(f,1),A(f,2),'y');
    %  end
end
total_circles=(n*(n-1)*(n-2))/6;
display(total_circles);
%valid_circles=k;
display(rh);






