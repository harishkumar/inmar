
class Chess
 attr_accessor :pos,:piece,:f,:l,:pIndex 
 #position, piece, firstindex, lastindex, givenpositionIndex

 def initialize(arg1,arg2,arg3,arg4)
 	@board = []
	if(arg1=="--target")
 	 createBoard(arg2,arg3)
	else
	 createBoard(arg2,arg4)
	end
 	printBoard
 end

 def getMoves
	if @pos!=nil && @piece!=nil
		if @piece.downcase == "rook"
			p rook
		elsif @piece.downcase == "knight"
			p knight
		elsif @piece.downcase == "queen"
			p queen
		else
			p "sorry, output only for rook,knight,queen"
		end
	else
	  "please pass arguments correctly like -piece Rook -position d2"
	end

 end

 def getDistantTile
 	fhr = @pIndex[0]-@f 
 	shr = @l-@pIndex[0]
 	distantRow = (shr > fhr) ? @l : @f

 	fhc = @pIndex[1]-@f 
 	shc = @l-@pIndex[1]
 	distantCol = (shc > fhc) ? @l : @f
 	return @board[distantRow][distantCol]
 end

 def getMovesToDistant
 	case @piece.downcase
 	when "rook"
 		rookMovesToDistant
 	when "knight"
		knightMovesToDistant
 	when "queen"
 		queenMovesToDistant
 	else
 		p "sorry, output only for rook"
 	end

 end

 private

 def createBoard(ag1,ag2)
 	cols=['a','b','c','d','e','f','g','h']
	rows=[1,2,3,4,5,6,7,8]
	@piece = ag1
	@pos = ag2
	temp=[]
	if @pos!=nil && @piece!=nil
		rows.reverse.each do |sub|
		  cols.each do |int|
		    temp << "#{int}#{sub}"
		  end
		  @board << temp
		  temp = []
		end
		@pIndex = getIndex(@pos)	
		@f =  rows.find_index(rows.first)
		@l =  rows.find_index(rows.last)
	end
 end

 def getIndex(box)
 	row = @board.detect{|aa| aa.include?(box)}
	return [@board.index(row),row.index(box)]
 end

 def printBoard
 	@board.each do |sub|
	  sub.each do |int|
	    print "#{int} "
	  end
	    puts "\n"
	end
	###p "index: #{@pIndex}" 
	puts "\n"
	
 end

 def rook
 	 hor=[]
	 ver=[]
	 (@f..@l).each do |y|
	   tA=[]
	   tA = @pIndex.dup
	   tA[0]=y
	   hor << @board[tA.first][tA.last] if @board[tA.first][tA.last]!=pos

	   tA=[]
	   tA = @pIndex.dup
	   tA[1]=y
	   ver << @board[tA.first][tA.last] if @board[tA.first][tA.last]!=pos
	 end
	 return (hor.concat ver).join(",")
 end

 def knight
  	positions = ["tL","tR","tML","tMR","bML","bMR","bL","bR"]
  	knightPos = []
  	positions.each do |pos|
	  tA=[]
	  tA = @pIndex.dup
	  case pos
	  when "tL"
	    tA[0] = tA[0]-2 < @f ? nil : tA[0]-2
	    tA[1] = tA[1]-1 < @f ? nil : tA[1]-1
	  when "tR"
	    tA[0] = tA[0]-2 < @f ? nil : tA[0]-2
	    tA[1] = tA[1]+1 > @l ? nil : tA[1]+1	    
	  when "tML"
	    tA[0] = tA[0]-1 < @f ? nil : tA[0]-1
	    tA[1] = tA[1]-2 < @f ? nil : tA[1]-2
	  when "tMR"
	    tA[0] = tA[0]-1 < @f ? nil : tA[0]-1
	    tA[1] = tA[1]+2 > @l ? nil : tA[1]+2
	  when "bML"
	    tA[0] = tA[0]+1 > @l ? nil : tA[0]+1
	    tA[1] = tA[1]-2 < @f ? nil : tA[1]-2
	  when "bMR"
	    tA[0] = tA[0]+1 > @l ? nil : tA[0]+1
	    tA[1] = tA[1]+2 > @l ? nil : tA[1]+2
	  when "bL"
	    tA[0] = tA[0]+2 > @l ? nil : tA[0]+2
	    tA[1] = tA[1]-1 < @f ? nil : tA[1]-1
	  when "bR"
	    tA[0] = tA[0]+2 < @f ? nil : tA[0]+2
	    tA[1] = tA[1]+1 > @l ? nil : tA[1]+1
	  end

	  knightPos << @board[tA[0]][tA[1]] if ((tA[0]!=nil && tA[1]!=nil) && defined? @board[tA[0]][tA[1]]!=nil)	   
    end
  
    return knightPos.join(",")  
 end

 def queen
 	positions = ["tL","tR","bL","bR"]
    tA=[]
	tA = @pIndex.dup
    qm=[]
    x=tA[1]..@f
	positions.each do |position|	  
	  case position
	  when "tL"
	  	c=tA[0]
	    x.first.downto(x.last).each do |val|
	        if(c>=@f)
		     qm << @board[c][val] if @board[c][val] != @pos
		     c=c-1
		    end
		end
	  when "tR"
	    c=tA[0]
	    (tA[1]..@l).each do |val|
	        if(c>=@f)
	  	   	 qm << @board[c][val] if @board[c][val] != @pos
	  	   	 c=c-1
	  	    end
	  	end
	  when "bL"
	  	c=tA[0]
	    x.first.downto(x.last).each do |val|
	       if(c<=@l)	
			   qm << @board[c][val] if @board[c][val] != @pos
			   c=c+1
		   end
		end
	  when "bR"
	  	c=tA[0]
	    (tA[1]..@l).each do |val|
	       if(c<=@l)	
			   qm << @board[c][val] if @board[c][val] != @pos
			   c=c+1
		   end
		end
	  end
  	end

  	return "#{rook},#{qm.join(',')}"
 end

 #---methods for distant moves of pieces
  def getRandomArray
  	randArray=[]
    loop do 
	  randArray=Array.new(8) { [rand(1...8),rand(1...8)] }
	  randArray = randArray.map {|x| @board[x[0]][x[1]]}
	  break if randArray.uniq.length==8 && !randArray.include?(@pos)
	end
	return randArray
  end

  def rookMovesToDistant
  		randArray = getRandomArray
 		p "Distant Destination: #{getDistantTile}"
 		print "Random pieces on board: "        		
		p randArray

 		moves=[]
 		gI=@pIndex.dup
 		dI=getIndex(getDistantTile).dup
        captured =false
    	x= gI[0]..dI[0]
    	(gI[0] > dI[0] ? x.first.downto(x.last) : x).each do |val|
    		if(randArray.include?(@board[val][gI[1]]))
    			 moves<<@board[val][gI[1]] 
    			 captured = true
    			 break 
    		else
    			 moves<<@board[val][gI[1]] 
    		end
    	end
    	

    	if !captured
	    	x= gI[1]..dI[1]
	    	(gI[1] > dI[1] ? x.first.downto(x.last) : x).each do |val|
	    		if(randArray.include?(@board[dI[0]][val]))
	    		 moves<<@board[dI[0]][val]
    			 captured = true
    			 break
    			else	    			
	    			moves<<@board[dI[0]][val]
	    		end
	    	end
    	end

    	p "---Final Moves of #{@piece} towards #{getDistantTile}, stops when captured any random piece----"
    	moves.delete(@pos)
        (moves.uniq!)
        p moves
 end

 def queenMovesToDistant
	randArray = getRandomArray
	p "Distant Destination: #{getDistantTile}"
	print "Random pieces on board: "        		
	p randArray
	gI=@pIndex.dup
 	dI=getIndex(getDistantTile).dup
	moves=[]

	x=(gI[0]..dI[0])
	c = gI[1]
	( gI[0]<dI[0] ? x : x.first.downto(x.last)).each do |val|
	 if(inLimits(val) && inLimits(c))
	  moves << @board[val][c]
	  if(gI[1] > dI[1])
	    c = c-1
	  else
	    c = c+1
	  end
	 end
	end
	
	turn1 = getIndex(moves.last)
	if(moves.last != getDistantTile)		
		if(turn1[0]!=dI[0])
		   x=(turn1[0]..dI[0])
		   c = turn1[1]
		  (turn1[0]<dI[0] ? x : x.first.downto(x.last)).each do |val|
			 if(inLimits(val) && inLimits(c))
			  moves << @board[val][c]
			  if(turn1[1] > dI[1])
			    c = c-1
			  elsif(turn1[1] < dI[1])
			    c = c+1			  
			  end
			 end
		  end
		elsif(turn1[1]!=dI[1]) #[0,3] - [0,7]
		  x=(turn1[1]..dI[1])
		  c = turn1[0]
		  (turn1[1]<dI[1] ? x : x.first.downto(x.last)).each do |val|
			 if(inLimits(val) && inLimits(c))
			  moves << @board[c][val]
			  if(turn1[0] > dI[0])
			    c = c-1
			  elsif(turn1[0] < dI[0])
			    c = c+1			  
			  end
			 end
		  end
		end

	end
	
	fmoves=[]
	moves.uniq.each do |val|
	 randArray.include?(val) ? (fmoves << val;break;) : fmoves << val
	end
	p "--Final Moves of #{@piece} towards #{getDistantTile}, stops when captured any random piece----"
	fmoves.delete(@pos)
        (fmoves.uniq!)
	p fmoves
 end

 def inLimits(val)
  val>=@f && val<=@l
 end

 def knightMovesToDistant
	randArray = getRandomArray
	p "Distant Destination: #{getDistantTile}"
	print "Random pieces on board: "        		
	p randArray
	fixedDistantTile = getDistantTile.dup
	#gI=@pIndex.dup
 	#dI=getIndex(getDistantTile).dup
	@knightdistantmoves=[]
	@norepeat=[]
	@test=0
	recurTillDist(fixedDistantTile,nil)	
	fmoves=[]
	@knightdistantmoves.uniq.each do |val|
	 randArray.include?(val) ? (fmoves << val;break;) : fmoves << val
	end
	puts "\n"
	p "--Final Moves of #{@piece} towards #{fixedDistantTile}, stops when captured any random piece----"
	p fmoves	
 end

 def recurTillDist(fixedDistantTile,spWhenRepeat)
	startPositions = spWhenRepeat==nil ? getDesiredPosKnightMoves(@pos).split(",") : spWhenRepeat	
	finalPositions = getDesiredPosKnightMoves(fixedDistantTile).split(",")
	gN = getNearestPos(startPositions,finalPositions,fixedDistantTile)
	nearestPos =  @board[gN[0]][gN[1]]
	###p "nearest: #{nearestPos}"
	@norepeat << nearestPos
	###print "nrep:"; p @norepeat;
	###print "startPositions:"; p startPositions
	
	if(@norepeat.uniq.length != @norepeat.length)
		startPositions.delete(@norepeat.last)
		@norepeat.pop
		recurTillDist(fixedDistantTile,startPositions)
	else
		@knightdistantmoves << nearestPos
		@pos = nearestPos
		@test = @test+1
		if(!@knightdistantmoves.include?(fixedDistantTile))
		 recurTillDist(fixedDistantTile,nil)	  
		end
	end
	
 end

 def getDesiredPosKnightMoves(pos)
	@pIndex = getIndex(pos)
	knight
 end

 def getNearestPos(gposs,dposs,fixedDistantTile)
      rws=[]
      cls=[]
      diffArr = []
      mainArr = []
      c=0
      dposs.each do |d|
	gposs.each do |g|
	  	
		gg =(getIndex g)[0]-(getIndex d)[0]
		gg = -gg if (gg < 0)
		rws << gg
		dd =(getIndex g)[1]-(getIndex d)[1]
		dd = -dd if (dd < 0)
		cls << dd
		#p "#{getIndex g} - #{getIndex d} => [#{rws[c]},#{cls[c]}] => #{rws[c]-cls[c]<0 ? -(rws[c]-cls[c]) : rws[c]-cls[c]} "
		mainArr << getIndex(g)
		diffArr << [rws[c],cls[c]]
		c=c+1
		
	end
      end
      smallarr= diffArr.sort[0]
      hash = Hash[diffArr.map.with_index.to_a] 
      if mainArr.include? (getIndex fixedDistantTile)
        getIndex(fixedDistantTile)
      else
	mainArr[hash[smallarr]]
      end
      
 end

end


# output
chess = Chess.new(ARGV[0],ARGV[1],ARGV[2],ARGV[3])

if(ARGV[1]!= nil && ARGV[3]!= nil && ARGV[0]!="--target" && (ARGV[1].downcase=="rook" || ARGV[1].downcase=="queen" || ARGV[1].downcase=="knight"))
	chess.getMoves
elsif(ARGV[1]!= nil && ARGV[0].downcase=="--target" && ARGV[2]!=nil && (ARGV[1].downcase=="rook" || ARGV[1].downcase=="queen" || ARGV[1].downcase=="knight")) 
	chess.getMovesToDistant
else
	p "please pass arguments correctly"
	p "to know positions pass: 'ruby chessercise.rb -piece Rook -position d2' & output only for rook,knight,queen"
	p "to move to distant pass: 'ruby chessercise.rb --target rook h2' "
end
