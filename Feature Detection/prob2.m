clear all 
load gradient.mat

x = rand*(rand*10);
y = rand*(rand*10);
guess = [x;y];
grad = gradF(guess);
plot(x,y,'ro');
hold on 
axis([0,10,0,10]);
pos = [x+0.5*grad(1);y+0.5*grad(2)];
plot(pos(1),pos(2), 'rs');

while (1)
 newpos = pos - 0.5*gradF([pos(1);pos(2)]);
 plot(newpos(1),newpos(2), 'bs');
 if (abs(newpos - pos) < .01)
     disp(['Found a local minimum at ' num2str(newpos(1)) ',' num2str(newpos(2))]);
     break
 end
 pos = newpos;
end