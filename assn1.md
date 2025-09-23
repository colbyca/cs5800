# CS5800 Assignment 1
## Colby Carter
### 1.
```
dsc_courses = σ title = 'Database System Concepts' (course)

π capacity ((dsc_courses ⨝ section) ⨝ classroom)
```

### 2.
```
π student.name, course.title (σ takes.grade = 'A' (student ⨝ takes ⨝ course))
```

### 3.
```
student - (student ⋉ takes)
```

### 4.
```
instructors_who_teach_big_classes = π teaches.ID ((σ classroom.capacity > 100 classroom) ⨝ section ⨝ teaches)
instructors_with_no_big_classes = (π ID (teaches)) - instructors_who_teach_big_classes
instructor ⋉ instructors_with_no_big_classes
```

### 5.
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

### 6.
```
γ title, course_id, semester, year; count(ID) → num_students ((course ⨝ section) ⟕ takes)
```

### 7.
```
course_students = γ title; count(ID) → num_students (course ⨝ takes)
 
non_max_courses = π a.title, a.num_students (σ a.num_students < b.num_students (ρ a (course_students) ⨯ ρ b (course_students)))
π title (course_students - non_max_courses)
```

### 8.
```
salaries = π salary (instructor)

non_max_salaries = π a.salary (σ a.salary < b.salary (ρ a (salaries) ⨯ ρ b (salaries)))

highest_salary = salaries - non_max_salaries

salaries_wo_highest = salaries - highest_salary

non_max_salaries2 = π c.salary (σ c.salary < d.salary (ρ c (salaries_wo_highest) ⨯ ρ d (salaries_wo_highest)))

sec_highest_salary = salaries_wo_highest - non_max_salaries2

π name, salary (instructor ⋉ (highest_salary ∪ sec_highest_salary))
```
or
```
max_salary_set = γ max(salary) → max_salary (instructor)

highest_salary = π ID, name, dept_name, salary (σ salary = max_salary (instructor ⨝ max_salary_set))

instructors_wo_highest = instructor - highest_salary

max_salary_set2 = γ max(salary) → max_salary (instructors_wo_highest)

sec_highest_salary = π ID, name, dept_name, salary (σ salary = max_salary (instructor ⨝ max_salary_set2))

π name, salary (highest_salary ∪ sec_highest_salary)
```

### 9.
```
student_semesters = π ID, semester (takes)
semesters_wo_summer = π semester (σ semester ≠ 'Summer' (section))
π name (student ⋉ (student_semesters ÷ semesters_wo_summer))
```

### 10.
```
dept_salary_totals = γ dept_name; sum(salary) → total_salary (instructor)
instructors_and_dept_sal_tot = dept_salary_totals ⨝ instructor
π ID, name, dept_name, salary (σ salary > total_salary - salary (instructors_and_dept_sal_tot))
```
