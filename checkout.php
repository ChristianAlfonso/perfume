<script src="https://www.paypalobjects.com/api/checkout.js"></script>
<?php 
$total = 0;
    $qry = $conn->query("SELECT c.*,p.product_name,i.size,i.price,p.id as pid from `cart` c inner join `inventory` i on i.id=c.inventory_id inner join products p on p.id = i.product_id where c.client_id = ".$_settings->userdata('id'));
    while($row= $qry->fetch_assoc()):
        $total += $row['price'] * $row['quantity'];
    endwhile;
?>
<section class="py-5">
    <div class="container">
        <div class="card rounded-0">
            <div class="card-body"></div>
            <h3 class="text-center"><b>Checkout</b></h3>
            <hr class="border-dark">
            <form action="" id="place_order">
                <input type="hidden" name="amount" value="<?php echo $total ?>">
                <input type="hidden" name="payment_method" value="cod">
                <input type="hidden" name="paid" value="0">
                <div class="row row-col-1 justify-content-center">
                    <div class="col-6">
                        <div class="form-group col">
                            <label for="" class="control-label">Delivery Address</label>
                            <textarea id="" cols="30" rows="3" name="delivery_address" class="form-control" style="resize:none"><?php echo $_settings->userdata('default_delivery_address') ?></textarea>
                        </div>
                        <div class="col">
                            <span><h4><b>Total:</b> <?php echo number_format($total) ?></h4></span>
                        </div>
                        <hr>
                        <div class="col my-3">
                            <h4 class="text-muted">Payment Method</h4>
                            <div class="d-flex w-100 justify-content-between">
                                <button class="btn btn-flat btn-dark" onclick="selectCOD()">Cash on Delivery</button>
                                <button class="btn btn-flat btn-primary" id="gcash-button" onclick="initiateGCashPayment()">Pay with GCash</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

<script>
function selectCOD() {
    $('[name="payment_method"]').val("Cash on Delivery");
    $('[name="paid"]').val(0);
    $('#place_order').submit();
}

function initiateGCashPayment() {
    event.preventDefault();
    const paymentData = {
        amount: '<?php echo $total; ?>',
        description: 'Purchase Checkout',
        client_id: '<?php echo $_settings->userdata('id') ?>',
    };

    start_loader();
    $.ajax({
        url: 'gcash_payment_endpoint.php',
        method: 'POST',
        data: paymentData,
        dataType: "json",
        success: function (response) {
            end_loader();
            if (response.success) {
                // Redirect to GCash payment page
                window.location.href = response.redirect_url;
            } else {
                alert_toast("GCash Payment initialization failed.", "error");
            }
        },
        error: function (err) {
            console.log(err);
            alert_toast("An error occurred while initiating GCash payment.", "error");
            end_loader();
        }
    });
}

$(function () {
    $('#place_order').submit(function (e) {
        e.preventDefault();
        start_loader();
        $.ajax({
            url: 'classes/Master.php?f=place_order',
            method: 'POST',
            data: $(this).serialize(),
            dataType: "json",
            success: function (resp) {
                end_loader();
                if (resp.status == 'success') {
                    alert_toast("Order Successfully placed.", "success");
                    setTimeout(function () {
                        location.replace('./');
                    }, 2000);
                } else {
                    console.log(resp);
                    alert_toast("An error occurred while placing the order.", "error");
                }
            },
            error: function (err) {
                console.log(err);
                alert_toast("An error occurred.", "error");
                end_loader();
            }
        });
    });
});
</script>
