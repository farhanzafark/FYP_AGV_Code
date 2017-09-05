function [path,closedList,pathToGoal] = a_star_1(graph,start,goal)
%open list all unvisited nodes
%closed list evaluated nodes
%list 'f' of the cost of each node

%variable to track break condition
breakVar = false;

pathToGoal = [];

p = plot(graph,'Layout','force','EdgeLabel',graph.Edges.Weight);

path = zeros(graph.numnodes,1);
openList = zeros(1,1);
openList(1,1) = start;
closedList = zeros(1,1);
closedListCount = 1;

cost_f = inf(graph.numnodes,1);
cost_f(start) = 0;
openList(1,2) = cost_f(start);
cost_g = inf(graph.numnodes,1);
cost_g(start) = 0;
cost_h = inf(graph.numnodes,1);

while ~isempty(openList)
   %find element in openList with minimum cost_f
   [M,I] = min(openList(:,2));
   q = openList(I,1);

   %    I = find(openList==q);
   % take q off openList
   openList(I,:) = [];
   %[m,n] = size(openList);
   %if openList is empty, make it a 1x2 matrix of zeros (as a placeholder)
%    if m == 1 && n == 1
%        openList = zeros(1,2);
%    end
   
   %generate neighbors of q
   N = neighbors(graph,q);
   for i = 1:length(N)
       %if successor is the goal, stop
      if N(i) == goal
          path(N(i)) = q;
          breakVar = true;
          pathToGoal = reconstructPath(path,goal);
          highlight(p,pathToGoal,'EdgeColor','r','LineWidth',1.5)
          break;
      end
      %calculate cost for neighbor
      tentative_gScore = cost_g(q) + distances(graph,q,N(i));
      cost_g(N(i)) = tentative_gScore;
      cost_f(N(i)) = cost_g(N(i))+ abs(p.XData(N(i))-p.XData(goal))+abs(p.YData(N(i))-p.YData(goal)); % + heuristic cost of neighbor
      
      %find neighbor in openList
      [neighborValue,neighborIndex] = find(openList(:,1)==N(i));
      if ~isempty(neighborIndex) 
          if openList(neighborIndex,2) <= cost_f(N(i));
            %break;
          end
      else
              [closedListElem,closedListInd] = find(closedList==N(i));
              if ~isempty(closedListInd)
                    if cost_f(closedListElem) <= cost_f(N(i));
                                %break;
                    end
              else
                  openList(end+1,:) = [N(i),cost_f(N(i))];
                  path(N(i)) = q;
              end
      end
      
      %if neighbor is on closedList with a smaller cost_f, skip; else add
      %to openList
      
      
      if breakVar
          break;
      end
   end
   
   %add q to closedList
   closedList(closedListCount) = q;
   closedListCount = closedListCount + 1;
   if breakVar
          break;
   end
end
end

function pathToGoal = reconstructPath(path,goal)
    pathToGoal = [];
    pathToGoal(end+1) = goal;    
    q = path(goal);
    while q~=0
        pathToGoal(end + 1) = q;
        q = path(q);
    end
end