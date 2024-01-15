package com.ahmadiallo.CMS.model;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonInclude;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;


@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class User {
   @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "firstname", nullable = false)
    @NotEmpty(message = "First name cannot be empty")
    private String firstname;

    @Column(name = "lastname", nullable = false)
    @NotEmpty(message = "Last name cannot be empty")
    private String lastname;

    @Column(name = "address", nullable = false)
    @NotEmpty(message = "Address cannot be empty")
    private String address;

    @Column(name = "email", nullable = false, unique = true)
    @NotEmpty(message = "Email cannot be empty")
    @Email(message = "Invalid Email Please Enter a valid email")
    private String email;

    @Column(name = "phone")
    private String phone;

    @Column(name = "title")
    private String title;

    @Column(name = "bio")
    private String bio;

    @Column(name = "enabled", columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean enabled;

    @Column(name = "non_locked", columnDefinition = "BOOLEAN DEFAULT TRUE")
    private Boolean nonLocked;

    @Column(name = "using_mfa", nullable = false, columnDefinition = "TINYINT DEFAULT 0")
    private Integer usingMfa;

    @Column(name = "created_date", columnDefinition = "DATETIME DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime createdDate;

    @Column(name = "image_url", columnDefinition = "VARCHAR(255) DEFAULT 'https://cdn-icons-png.flaticon.com/512/149/149071.png'")
    private String imageUrl;

    private LocalDateTime createdAt;
}

