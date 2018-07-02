package userLogin;

import java.util.Iterator;
import java.util.List;

import org.hibernate.*;
import org.hibernate.cfg.*;

public class UserLogin_main
{
    public static void main(String[] args) 
    {
        Configuration cfg=new Configuration();
        cfg.configure("Hibernate.cfg.xml");
        System.out.println("Loaded Configuration .........");
        
        SessionFactory sf=cfg.buildSessionFactory();
        System.out.println("Loaded SessionFactory ..........");
        
        Session s=sf.openSession();
        System.out.println("Loaded Session ..........");
        
//        Query q= s.createSQLQuery("select * from userlogin");
//        List l = q.list();
//        Iterator it = l.iterator();
//        while(it.hasNext())
//        {
//        	Object st[] = (Object[])it.next();
//        	System.out.println(st[0]+" "+st[1]+" "+st[2]);
//        }
           UserLogin p = new UserLogin();
           p.setPassword("abc");
           p.setUserName("ashwin");
           s.save(p);
           Transaction t = s.beginTransaction();
           t.commit();
        
        System.out.println("Loaded Transaction .........");
        
        s.close();
        sf.close();
    }
    
}
