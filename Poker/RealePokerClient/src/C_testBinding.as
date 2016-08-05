package
{
	public class C_testBinding
	{
		private var m_model:M_testBinding = M_testBinding.getInstance();
		public function C_testBinding()
		{
		}
		
		public function beginBind(min: String, max: String, value: String):void{
			m_model.iRaiseValue = parseFloat(value);
			m_model.strRaiseValue = value;
			m_model.strValue = value;
			m_model.minnimum = parseFloat(min);
			m_model.maximum = parseFloat(max);
		}
	}
}