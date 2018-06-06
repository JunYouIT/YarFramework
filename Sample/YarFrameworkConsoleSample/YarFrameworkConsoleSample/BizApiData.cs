using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Yar.Service;

namespace YarFrameworkConsoleSample
{
    public class BizApiData : BaseBusiness
    {

        public BusinessResult Get(BusinessContext context)
        {
            return this.OK(new { Msg = "test message" });
        }
    }
}
