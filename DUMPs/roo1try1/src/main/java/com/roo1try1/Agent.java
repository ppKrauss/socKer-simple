package com.roo1try1;
import org.springframework.roo.addon.dbre.RooDbManaged;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;

@RooJavaBean
@RooJpaActiveRecord(versionField = "", table = "agent", schema = "socker")
@RooDbManaged(automaticallyDelete = true)
@RooToString(excludeFields = { "agentTelcoms" })
public class Agent {
}
