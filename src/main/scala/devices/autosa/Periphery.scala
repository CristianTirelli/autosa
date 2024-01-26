// See LICENSE for license details.
package autosa.blocks.dla

import chisel3._
import org.chipsalliance.cde.config.Field
import freechips.rocketchip.subsystem.BaseSubsystem
import freechips.rocketchip.diplomacy.{LazyModule,BufferParams}
import freechips.rocketchip.tilelink.{TLBuffer, TLIdentityNode, TLWidthWidget, TLFragmenter}

case object AUTOSAKey extends Field[Option[AUTOSAParams]](None)
case object AUTOSAFrontBusExtraBuffers extends Field[Int](0)

trait CanHavePeripheryAUTOSA { this: BaseSubsystem =>
  p(AUTOSAKey).map { params =>
    val autosa = LazyModule(new AUTOSA(params))

  

    //fbus.coupleFrom("autosa_control") { _ := TLBuffer.chainNode(p(AUTOSAFrontBusExtraBuffers)) := autosa.gmem_A_tl_node }
    pbus.coupleTo("autosa_control") { autosa.control_tl_node := TLBuffer.chainNode(p(AUTOSAFrontBusExtraBuffers)) := _ }
    
    //pbus.coupleTo("autosa_control") { _ := TLWidthWidget(pbus.beatBytes) := TLFragmenter(8, pbus.blockBytes) := autosa.control_tl_node}
    //pbus.coupleFrom("autosa_gmem_B") { _ := TLWidthWidget(pbus.beatBytes) := TLFragmenter(8, pbus.blockBytes) := autosa.gmem_B_tl_node}
    //pbus.coupleFrom("autosa_gmem_C") { _ := TLWidthWidget(pbus.beatBytes) := TLFragmenter(8, pbus.blockBytes) := autosa.gmem_C_tl_node}
    //pbus.coupleTo("autosa_gmem_B") { autosa.gmem_B_tl_node := TLFragmenter(4, pbus.blockBytes) := TLWidthWidget(pbus.beatBytes) := _ }
    //pbus.coupleTo("autosa_gmem_C") { autosa.gmem_C_tl_node := TLFragmenter(4, pbus.blockBytes) := TLWidthWidget(pbus.beatBytes) := _ }
    
    fbus.coupleFrom("autosa_gmem_A") { _ := TLBuffer.chainNode(p(AUTOSAFrontBusExtraBuffers)) := autosa.gmem_A_tl_node }
    fbus.coupleFrom("autosa_gmem_B") { _ := TLBuffer.chainNode(p(AUTOSAFrontBusExtraBuffers)) := autosa.gmem_B_tl_node }
    fbus.coupleFrom("autosa_gmem_C") { _ := TLBuffer.chainNode(p(AUTOSAFrontBusExtraBuffers)) := autosa.gmem_C_tl_node }


    ibus.fromSync := autosa.int_node
  }
}
