% [x,y] = input_free_form_curve(h_text);
%
% Input a free form curve -- the start will be the location of
% the first knot.  A curve is input as a set of lines.  Left click
% to add another line (or the first point of the curve).  Right
% click to close the curve and finish.  
%
% Input:
% h_text (optional): Handle of a text box to output directions to.
% If no such handle is input, then directions are output to
% stdout.  
%
% Output:
% [x,y]: The locations of the clicked points.  
%
% Dependencies:
% myginput (same as ginput, but doesn't change the cursor).  
%
function [x,y] = input_free_form_curve(h_text);

is_hold = ishold;
hold on;

if exist('h_text') & ishandle(h_text),
  istextbox = 1;
else,
  istextbox = 0;
end;

%%% Input the first point

% Directions for the first point
direction_string{1} = 'Input a free form curve: ';
direction_string{2} = 'Left click the start of the curve. ';
direction_string{3} = 'This point will be the first knot of the B-Spline. ';
 
if istextbox,
  set(h_text,'string',direction_string);
else,
  fprintf(cell2mat(direction_string));
end;

b = 2;
while b ~= 1,
  [x,y,b] = ginput(1);
end;

h = plot(x,y,'x','erasemode','none','color','r','markersize',6,'linewidth',2);

%%% Input the rest of the points on the curve

% Directions for the rest of the points
direction_string{2} = 'Left click to add a new line. ';
direction_string{3} = 'Right click to close the curve.';

if istextbox,
  set(h_text,'string',direction_string);
else,
  fprintf(cell2mat(direction_string));
end;

while b ~= 3,
  [cx,cy,b] = ginput(1);
  if b == 1,
    x = [x;cx];
    y = [y;cy];
    h = plot(x(end-1:end),y(end-1:end),'-','erasemode','none', ...
	     'color','r','linewidth',2);
  elseif b == 3,
    h = plot(x([end,1]),y([end,1]),'-','erasemode','none', ...
	     'color','r','linewidth',2);
  end;
end;

if istextbox,
  set(h_text,'string','Input a free form curve:  DONE!');
end;

if is_hold == 0,
  hold off;
end;
