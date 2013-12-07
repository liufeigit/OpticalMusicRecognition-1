function[outchar] = readFindNotes(centroid,lines)


OutChar = {'e4','d4','c4','b3','a3','g3','f3','e3','d3','c3','b2','a2','g2','f2','e2','d2','c2'};

LookUpTable = zeros(1,13+4);
lineDist = 9.5;%calcLineDist(lines,0);
LookUpTable(1)  = lines(1)-lineDist*3;
LookUpTable(2)  = lines(1)-lineDist*(5/2);
LookUpTable(3)  = lines(1)-lineDist*2;
LookUpTable(4)  = lines(1)-lineDist*(3/2);
LookUpTable(5)  = lines(1)-lineDist;
LookUpTable(6)  = lines(1)-lineDist/2;
LookUpTable(7)  = lines(1) ;
LookUpTable(8)  = lines(1) + (lines(2)-lines(1))/2;
LookUpTable(9)  = lines(2) ;
LookUpTable(10)  = lines(2) + (lines(3)-lines(2))/2;
LookUpTable(11)  = lines(3) ;
LookUpTable(12)  = lines(3) + (lines(4)-lines(3))/2;
LookUpTable(13)  = lines(4);
LookUpTable(14) = lines(4) + (lines(5)-lines(4))/2;
LookUpTable(15) = lines(5);
LookUpTable(16) = lines(5)+lineDist/2;
LookUpTable(17) = lines(5)+lineDist;
LookUpTable = round(LookUpTable);

distance =  abs(LookUpTable-ceil(centroid(1,2)));
[~,idx] =min(distance);
line = LookUpTable(idx);
        
outchar = OutChar{LookUpTable==line};

end