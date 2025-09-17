
1. List the room capacity of the course section(s) for "Database System Concepts".
```
dsc_courses = σ title = 'Database System Concepts' (course)

π capacity ((dsc_courses ⨝ section) ⨝ classroom)
```

2. List the name of the student and the title of the course for each student who earned an "A" in a course.
```
π student.name, course.title (σ takes.grade = 'A' (student ⨝ takes ⨝ course))
```

3. List the students who do not take a course.
```
student - (student ⋉ takes)
```
or maybe
```
σ tot_cred = 0 (student)
```

4. Of the instructors that teach, list the instructors who do not teach any section that has a room capacity of more than 100.
```
instructors_who_teach_big_classes = π teaches.ID ((σ classroom.capacity > 100 classroom) ⨝ section ⨝ teaches)
instructors_with_no_big_classes = (π ID (teaches)) - instructors_who_teach_big_classes
π name (instructor ⨝ instructors_with_no_big_classes)
```

5. List the building and the maximum salary among all of the instructors that are in a department in that building.
```
instructors_department = instructor ⨝ department
dual_instructors_department = ρ a (instructors_department) ⨯ ρ b (instructors_department)
not_max_salaries = π a.building, a.salary (σ a.building = b.building ∧ a.salary < b.salary (dual_instructors_department))

π building, salary (instructors_department) - not_max_salaries
```
or better
```
instructors_department = instructor ⨝ department
γ building; max(salary) → max_salary (instructors_department)
```

6. For every course, list the title, course_id, semester, year and number of students that take the course (you may assume the course_id is unique but two courses may have the same title).
```
γ course_id, title, semester, year; count(ID) → num_students (course ⨝ takes)
```

7. List the title of the course that has the most students taking it.
```
course_students = γ title; count(ID) → num_students (course ⨝ takes)
 
non_max_courses = π a.title, a.num_students (σ a.num_students < b.num_students (ρ a (course_students) ⨯ ρ b (course_students)))
π title (course_students - non_max_courses)
```
8. List the names and salaries of instructor(s) that have the highest and second highest salary.
```
salaries = π salary (instructor)
non_max_salaries = π a.salary (σ a.salary < b.salary (ρ a (salaries) ⨯ ρ b (salaries)))
highest_salary = salaries - non_max_salaries
salaries_wo_highest = salaries - highest_salary
non_max_salaries2 = π c.salary (σ c.salary < d.salary (ρ c (salaries_wo_highest) ⨯ ρ d (salaries_wo_highest)))
sec_highest_salary = salaries_wo_highest - non_max_salaries2
instructor ⋉ (highest_salary ∪ sec_highest_salary)
```
or
```
max_salary_set = γ max(salary) → max_salary (instructor)
highest_salary = π ID, name, dept_name, salary (σ salary = max_salary (instructor ⨝ max_salary_set))
instructors_wo_highest = instructor - highest_salary
max_salary_set2 = γ max(salary) → max_salary (instructors_wo_highest)
sec_highest_salary = π ID, name, dept_name, salary (σ salary = max_salary (instructor ⨝ max_salary_set2))
highest_salary ∪ sec_highest_salary
```
9. List the names of the students who take courses in all of the semesters except "Summer" (you should compute the names of semesters, it could be more than just "Fall", "Spring", and "Summer").
```
student_semesters = π ID, semester (takes)
semesters_wo_summer = π semester (σ semester ≠ 'Summer' (section))
student ⋉ (student_semesters ÷ semesters_wo_summer)
```

10. (Extra credit) List the instructors that have a higher salary than everyone else in their department combined.
```
dept_salary_totals = γ dept_name; sum(salary) → total_salary (instructor)
instructors_and_dept_sal_tot = dept_salary_totals ⨝ instructor
σ salary > total_salary - salary (instructors_and_dept_sal_tot)
```
