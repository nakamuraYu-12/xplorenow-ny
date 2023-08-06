document.addEventListener('DOMContentLoaded', function() {
  function setRemoveButtonEvent(button) {
    button.addEventListener('click', function() {
      button.closest('.date-row').remove();
      updateRemoveButtonsVisibility();
    });
  }

  function updateRemoveButtonsVisibility() {
    var removeButtons = document.querySelectorAll('.remove-date');
    if (removeButtons.length <= 1) {
      removeButtons.forEach(function(button) {
        button.style.display = 'none';
      });
    } else {
      removeButtons.forEach(function(button) {
        button.style.display = 'inline-block';
      });
    }
  }

  document.getElementById('add-date').addEventListener('click', function() {
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

    document.getElementById('dates-container').appendChild(newRow);

    setRemoveButtonEvent(newRow.querySelector('.remove-date'));

    updateRemoveButtonsVisibility();
  });

  var initialRemoveButtons = document.querySelectorAll('.remove-date');
  initialRemoveButtons.forEach(function(button) {
    setRemoveButtonEvent(button);
  });

  updateRemoveButtonsVisibility();
});
