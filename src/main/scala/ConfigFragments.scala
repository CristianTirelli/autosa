// See LICENSE for license details.
package autosa.blocks.dla

import chisel3._

import org.chipsalliance.cde.config.{Field, Parameters, Config}

class WithAUTOSA(config: String) extends Config((site, here, up) => {
  case AUTOSAKey => Some(AUTOSAParams(config = config, raddress = 0x10040000L))
})
