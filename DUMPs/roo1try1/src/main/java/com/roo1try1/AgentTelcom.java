package com.roo1try1;
import org.springframework.roo.addon.dbre.RooDbManaged;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooJpaActiveRecord(identifierType = AgentTelcomPK.class, versionField = "", table = "agent_telcom", schema = "socker")
@RooDbManaged(automaticallyDelete = true)
@RooToString(excludeFields = { "agid", "idTelcom" })
public class AgentTelcom {
}
