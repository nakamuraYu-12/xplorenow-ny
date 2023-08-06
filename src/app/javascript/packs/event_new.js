document.addEventListener('DOMContentLoaded', function() {
  // 削除ボタンのクリックイベントを設定する関数
  function setRemoveButtonEvent(button) {
    button.addEventListener('click', function() {
      button.closest('.date-row').remove(); // クリックされた日付フィールドを削除
      updateRemoveButtonsVisibility(); // 削除ボタンの表示を更新
    });
  }

  // 削除ボタンの表示を更新する関数
  function updateRemoveButtonsVisibility() {
    var removeButtons = document.querySelectorAll('.remove-date');
    if (removeButtons.length <= 1) {
      removeButtons.forEach(function(button) {
        button.style.display = 'none'; // 削除ボタンを非表示にする
      });
    } else {
      removeButtons.forEach(function(button) {
        button.style.display = 'inline-block'; // 削除ボタンを表示する
      });
    }
  }

  // 追加ボタンのクリックイベント
  document.getElementById('add-date').addEventListener('click', function() {
    // 新しい日付フィールドを作成
    var newRow = document.createElement('div');
    newRow.classList.add('date-row', 'd-flex', 'flex-row', 'align-items-end', 'mb-3', 'mt-1');
    newRow.innerHTML = `
      <div class="field me-2">
        <label class="form-label mb-1 ps-2">開催日時</label>
        <input type="date" name="event[event_dates_attributes][new_dates][event_date]" class="form-control" data-behavior="datepicker">
      </div>
      <div class="field me-2">
        <label class="form-label mb-1 ps-2">開始時間</label>
        <div class="input-group">
          <input type="time" name="event[event_dates_attributes][new_dates][start_time]" class="form-control timepicker">
        </div>
      </div>
      <div class="field me-4">
        <label class="form-label mb-1 ps-2">終了時間</label>
        <div class="input-group">
          <input type="time" name="event[event_dates_attributes][new_dates][end_time]" class="form-control timepicker">
        </div>
      </div>
      <div class="remove-date-btn">
        <button type="button" class="remove-date btn btn-danger">削除</button>
      </div>
    `;

    // 新しい日付フィールドをフォームのコンテナに追加
    document.getElementById('dates-container').appendChild(newRow);

    // 新しい削除ボタンのクリックイベントを設定
    setRemoveButtonEvent(newRow.querySelector('.remove-date'));

    updateRemoveButtonsVisibility(); // 削除ボタンの表示を更新
  });

  // 最初に存在する削除ボタンのクリックイベントを設定
  var initialRemoveButtons = document.querySelectorAll('.remove-date');
  initialRemoveButtons.forEach(function(button) {
    setRemoveButtonEvent(button);
  });

  // ページ読み込み時に削除ボタンの表示を更新
  updateRemoveButtonsVisibility();
});
