function [path,cost] = a_star(graph,start,goal)
%open list all unvisited nodes
%closed list evaluated nodes
%list 'f' of the cost of each node

%variable to track break condition
breakVar = false;

p = plot(graph,'Layout','force','EdgeLabel',graph.Edges.Weight);

path = zeros(graph.numnodes,1);
openList = zeros(1,1);
openList(1,1) = start;
closedList = zeros(1);
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
   openList(I) = [];
   [m,n] = size(openList);
   %if openList is empty, make it a 1x2 matrix of zeros (as a placeholder)
   if m == 1
       openList = zeros(1,2);
   end
   
   %add q to closedList
   closedList(closedListCount) = q;
   closedListCount = closedListCount + 1;
   
   %generate neighbors of q
   N = neighbors(graph,q);
   for i = 1:length(N)
       %if successor is the goal, stop
      if N(i) == goal
          breakVar = true;
          break;
      end
      
      %if neighbor is not on openList, add to openList
      if isempty(find(openList(:,1)==N(i), 1))
          if m == 1
              openList(m,:) = [N(i),cost_f(N(i))];
          else
              openList(m+1,:) = [N(i),cost_f(N(i))];
          end
      end
      tentative_gScore = cost_g(q) + distances(graph,q,N(i));
      cost_g(N(i)) = tentative_gScore;
      cost_f(N(i)) = cost_g(N(i))+ abs(p.XData(N(i))-p.XData(goal))+abs(p.YData(N(i))-p.YData(goal)); % + heuristic cost of neighbor
      if tentative_gScore >= cost_g(N(i)) && ~isempty(find(closedList==N(i)))
          break;
      else
         path(N(i)) = q;
          
         
         [elem,ind] = find(openList(:,1)==N(i));
         if ~isempty(ind)
             openList(ind,2) = cost_f(N(i));
         end
         
      end
      if breakVar
          break;
      end
   end
   if breakVar
          break;
      end
end
