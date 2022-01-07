classdef Life < handle
    properties
        board
        size
        birthFromVoid
    end
    
    methods
        function obj = Life(w, h)
            obj.board = zeros(w, h);
            obj.size = [w, h];
            obj.birthFromVoid = 0;
        end
        
        function obj = fillRand(obj)
            rng();
            obj.board = randi(2, obj.size(1), obj.size(2)) - 1;
        end

        function obj = nextCycle(obj)
            for i = 1:obj.birthFromVoid
                obj.board(randi(obj.size(2)), randi(obj.size(1))) = 1;
            end
            prevBoard = obj.board;
            for y = 1:obj.size(2)
                for x = 1:obj.size(1)
                    neighbors = getNeighbors(obj, prevBoard, x, y);
                    if (prevBoard(y, x) == 1 && (neighbors < 2 || neighbors > 3))
                        obj.board(y, x) = 0;
                    elseif (prevBoard(y, x) == 0 && neighbors == 3)
                        obj.board(y, x) = 1;
                    end
                end
            end
        end
    end
end

function neighbors = getNeighbors(obj, board, x, y)
    yRange = y - 1:y + 1;
    xRange = x - 1:x + 1;
    yRange = yRange(yRange > 0);
    yRange = yRange(yRange <= obj.size(2));
    xRange = xRange(xRange > 0);
    xRange = xRange(xRange <= obj.size(1));
    neighbors = sum(sum(board(yRange, xRange)));
    if (board(y, x) == 1)
        neighbors = neighbors - 1;
    end
end