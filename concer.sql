/* 

*/
set serveroutput on
declare
    --部门光标
    cursor cdept is select deptno from dept;
    pdeptno dept.deptno%type;

    --部门中员工薪水
    curcor cemp(dno number) is select sal from emp where deptno = dno;
    psal emp.sal%type;

    --每个段的员工数
    count1 number;
    count2 number;
    count3 number;

    --每个部门工资总和
    saltotal number

    --打开部门光标
    open cdept;
    loop
        --取出一个部门
        fetch cdept into pdeptno;
        exit when cdept%notfound;

        --初始化
        count1:=0;count2:=0;count3:=0;
        --得到部门的工资总和
        select sum(sal) into saltotal from emp where deptno = pdeptno;

        --取出部门员工薪水
        open cemp(pdeptno);
        loop
            --取一个员工的薪水
            fetch cemp into psal;
            exit when cemp%notfound;
            --判断区间
            if psal < 3000 then count1:=count1+1;
                elsif psal >= 3000 and psal < 6000 then count2:=count2+1;
                else count3:=count3=1；
            end if;
        end loop;
        close cemp;
        --保存结果
        insert into msg values(pdeptno,count1,count2,count3,saltotal)
    end loop;
    close cdept;
    commit;
    dbms_output.put_line('统计完成');
    end;
    /