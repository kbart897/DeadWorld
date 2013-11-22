package game.tiles
{
	import game.entities.Entity;

	public class V_Chunk
	{
		private var _lChunk:L_Chunk;
		
		private var _top:V_Chunk;
		private var _right:V_Chunk;
		private var _bottom:V_Chunk;
		private var _left:V_Chunk;
		
		public function V_Chunk()
		{
			
		}

		//====================================
		// BEGIN GETTERS/SETTERS
		//====================================
		
		public function get left():V_Chunk
		{
			return _left;
		}

		public function set left(value:V_Chunk):void
		{
			_left = value;
			if (!_left.right)
			{
				_left.right = this;
			}
		}

		public function get bottom():V_Chunk
		{
			return _bottom;
		}

		public function set bottom(value:V_Chunk):void
		{
			_bottom = value;
			if (!_bottom.top)
			{
				_bottom.top = this;
			}
		}

		public function get right():V_Chunk
		{
			return _right;
		}

		public function set right(value:V_Chunk):void
		{
			_right = value;
			if (!_right.left)
			{
				_right.left = this;
			}
		}

		public function get top():V_Chunk
		{
			return _top;
		}

		public function set top(value:V_Chunk):void
		{
			_top = value;
			if (!_top.bottom)
			{
				_top.bottom = this;
			}
		}

		public function get lChunk():L_Chunk
		{
			return _lChunk;
		}

		public function set lChunk(value:L_Chunk):void
		{
			if (_lChunk)
			{
				for each (var e:Entity in _lChunk.entities)
				{
//					if (!e.changingChunk)
//					{
						e.wake(false);
//					}
//					else if (!e.currTile.chunk.loaded || e.currTile.chunk)
//					{
//						e.wake(false);
//					}
				}
				_lChunk.loaded = false;
				_lChunk.vChunk = null;
			}
			_lChunk = value;
			_lChunk.vChunk = this;
			_lChunk.loaded = true;
			
			
			for each (var e:Entity in _lChunk.entities)
			{
				e.wake(true);
			}
		}
		//====================================
		// END GETTERS/SETTERS
		//====================================
	}
}