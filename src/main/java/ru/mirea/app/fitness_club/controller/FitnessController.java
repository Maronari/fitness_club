package ru.mirea.app.fitness_club.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import ru.mirea.app.fitness_club.ORM.Members;
import ru.mirea.app.fitness_club.Service.MembersService;
import ru.mirea.app.fitness_club.Service.ClubsService;
@Controller
@AllArgsConstructor
@RequestMapping(value= "/")
public class FitnessController {
    private final MembersService membersService;
    private final ClubsService clubsService;

    @GetMapping("/profile/{id}")
    public String profile(@PathVariable Integer id, Model model) {
        model.addAttribute("id", id);
        Members member = membersService.getMember(id);
        model.addAttribute("memberClub", member.getClub());
        model.addAttribute("roleName", member.getMembershipRole().getRole_name());
        model.addAttribute("member", member);
        model.addAttribute("achievements", membersService.getMemberAchievements(id));
        model.addAttribute("workouts", membersService.getListOfTrainingSchedule(id));
        model.addAttribute("photoURL", membersService.getPhotoUrl(id));
        model.addAttribute("news", clubsService.getListOfClubNews(member.getClub().getClub_name()));
        return "html/profile";
    }

    @GetMapping("/calendar/{id}")
    public String calendar(@PathVariable Integer id, Model model) {
        Members member = membersService.getMember(id);
        model.addAttribute("member", member);
        return "html/calendar";
    }

    @GetMapping("/login")
	String login() {
		return "html/login";
	}

}
