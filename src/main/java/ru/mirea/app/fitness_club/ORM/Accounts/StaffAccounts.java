package ru.mirea.app.fitness_club.ORM.Accounts;

import java.sql.Date;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import ru.mirea.app.fitness_club.ORM.Staff;
import ru.mirea.app.fitness_club.ORM.StaffPhoto;

@Entity
@Table(name = "staff_accounts")
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class StaffAccounts {
    @Id
    private String username;

    @OneToOne
    @JoinColumn(name = "id_staff", nullable = false)
    private Staff staff;

    private String password;
    private Date last_login;
    private Date account_creation_date;
    private String user_role;    

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_staff_photo")
    private StaffPhoto staffPhoto;
}
