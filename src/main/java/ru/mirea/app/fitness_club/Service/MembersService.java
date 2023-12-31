package ru.mirea.app.fitness_club.Service;

import java.util.List;
import java.util.Set;
import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import ru.mirea.app.fitness_club.ORM.Achievements;
import ru.mirea.app.fitness_club.ORM.EquipmentStatistics;
import ru.mirea.app.fitness_club.ORM.Feedback;
import ru.mirea.app.fitness_club.ORM.InbodyAnalyses;
import ru.mirea.app.fitness_club.ORM.Members;
import ru.mirea.app.fitness_club.ORM.TrainingSchedule;
import ru.mirea.app.fitness_club.ORM.Visits;
import ru.mirea.app.fitness_club.ORM.Accounts.MembersAccounts;
import ru.mirea.app.fitness_club.Repository.MembersRepository;

@Service
@AllArgsConstructor
public class MembersService {
    private final MembersRepository membersRepository;

    public Members getMember(Integer id) {
        return membersRepository.findById(id).orElse(null);
    }

    public List<Achievements> getListOfMemberAchievements(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null); 
        return member.getMemberAchievements();
    }

    public Set<TrainingSchedule> getListOfTrainingSchedule(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        Set<TrainingSchedule> memberTrainings = member.getMemberTrainingSchedules();
        return memberTrainings;
    }

    // public String getTrainingTypeName(int memberId) {
    //     Set<TrainingSchedule> trainingSchedule = getListOfTrainingSchedule(memberId);
    //     return trainingSchedule.get(memberId).getTrainingType().getTraining_type_name();
    // }

    public MembersAccounts getMemberAccount(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        return member.getMemberAccounts();
    }

    public String getPhotoUrl(int memberId) {
        MembersAccounts memberAccounts = getMemberAccount(memberId);
        try {
            return memberAccounts.getUserPhoto().getImage_url();
        } catch (Exception e) {
            return "https://i.postimg.cc/Wbznd0qn/1674365371-3-34.jpg";
        }
    }

    public List<Feedback> getListOFeedbacks(int memberId) {
        MembersAccounts memberAccounts = getMemberAccount(memberId);
        return memberAccounts.getFeedbacks();
    }

    public String getNutritionPlanDescription(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        return member.getNutritionPlans().getNutrition_description();
    }

    public Date getNutritionPlanStart(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        return member.getNutritionPlans().getStart_date();
    }

    public List<Visits> getListOfVisits(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        return member.getMembersVisits();
    }

    public Date getLastVisitDate(int memberId) {
        List<Visits> visits = getListOfVisits(memberId);
        return visits.get(visits.size()-1).getVisit_date();  
    }

    public String getMemberRolename(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        return member.getMembershipRole().getRole_name();
    }

    public List<InbodyAnalyses> getListOfInbodyAnalyses(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        return member.getMemberInbodyAnalyses();
    }

    public List<EquipmentStatistics> getListOfEquipmentStatistics(int memberId) {
        Members member = membersRepository.findById(memberId).orElse(null);
        return member.getMemberEquipmentStatistics();
    }

    public String getActivityName(int memberId,int statisticsId) {
        List<EquipmentStatistics> equipmentStatistics = getListOfEquipmentStatistics(memberId); 
        for (EquipmentStatistics equipmentStatistic : equipmentStatistics) {
            if (equipmentStatistic.getId_statistics() == statisticsId) {
                return equipmentStatistic.getActivityType().getActivity_name();
            }
        }
        return null;
    }

    public Members save(Members member) {
        return membersRepository.save(member);
    }
}
