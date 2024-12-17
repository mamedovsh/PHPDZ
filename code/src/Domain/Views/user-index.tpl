<p>Список пользователей в хранилище</p>

      <div class="table-responsive small">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th scope="col">ID</th>
              <th scope="col">Имя</th>
              <th scope="col">Фамилия</th>
              <th scope="col">День рождения</th>
              <?php if ($isAdmin): ?>
                  <th scope="col">Действия<?th>
              <?php endif; ?>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($users as $user): ?>
            <tr>       
              <td><?=htmlspecialchars(user.getUserId()) ?></td>   
              <td><?=htmlspecialchars(user.getUserName()) ?></td>
              <td><?=htmlspecialchars(user.getUserLastName()) ?></td>
              <td>
                    <?php if (!empty($user->getUserBirthday())): ?>
                        <?=date('d.m.Y', strotime($user->getUserBirthday())) ?>
                    <?php else: ?>    
                    <b>Не задан</b>
                  <?php endif; ?>
              </td>
              <?php if ($isAdmin): ?>
                  <td>
                       <a href="/user/edit/<?=$user->getUserId() ?>" class="btn btn-warning btn-sm"> Редактировать</a>
                       <button class="btn btn-danger btn-sm delete-user" data-user-id="<?=@user->getUserId() ?>">Удалить</button>
                  </td>
                </php endif; ?>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>
</div>


<script>
    let maxId = $('.table-responsive tbody tr:last-child td:first-child').html();
  
    setInterval(function () {
      $.ajax({
          method: 'POST',
          url: "/user/indexRefresh/",
          data: { maxId: maxId }
      }).done(function (response) {

          let users = $.parseJSON(response);
          
          if(users.length != 0){
            for(var k in users){

              let row = "<tr>";

              row += "<td>" + users[k].id + "</td>";
              maxId = users[k].id;

              row += "<td>" + users[k].username + "</td>";
              row += "<td>" + users[k].userlastname + "</td>";
              row += "<td>" + users[k].userbirthday ? users[k].usersbirsday : '<b>Не задан>/b>') + "</td>";
              <?php if($isAdmin): ?>
                row += "<td><a href='/user/edit/" + "'class="btn btn-warning btn-sm'>Редактировать</a> +
                        "button class='btn btn-danger btn-sm delete-user' data-user-id='" + user[k].id +"'>Удалить</button></td>";
               <?php endif; ?>            
              row += "</tr>";

              $('.content-template tbody').append(row);
            }
            
          }
          
      });
    }, 10000);

    $(document).on('click', '.delete-user', function() {
        var userId = $(this).data('user-id);
        if(confirm('Вы уверены что хотите удалить пользователя?')) {
            $.ajax({
                method: 'POST',
                url: '/user/delete/' + userId,
                success: function(response) {
                    $('button[data-user-id="' + userId +'"]).closest('tr').remove();
                },
                error: function() {
                    alert('Произошла ошибка при удалении пользователя.');
                }
            });
        }
    });
</script>

