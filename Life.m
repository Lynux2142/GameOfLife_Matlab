classdef Life < handle
    properties
        board
        width
        height
    end
    
    methods
        function obj = Life(w, h)
            obj.board = zeros(w, h);
            obj.width = w;
            obj.height = h;
        end
        
        function obj = fillRand(obj)
            rng();
            obj.board = randi(2, obj.width, obj.height) - 1;
        end

        function obj = nextCycle(obj, n)
            arguments
                obj
                n int32 {mustBeNonnegative} = 0;
            end
            for i = 0:n
                obj.board(randi(obj.height), randi(obj.width)) = 1;
            end
            prevBoard = obj.board;
            for y = 1:obj.height
                for x = 1:obj.width
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
    yRange = yRange(yRange <= obj.height);
    xRange = xRange(xRange > 0);
    xRange = xRange(xRange <= obj.width);
    neighbors = sum(sum(board(yRange, xRange)));
    if (board(y, x) == 1)
        neighbors = neighbors - 1;
    end
end