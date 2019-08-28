<!doctype html>

<?php
  //Connexion à la bdd
  $db = mysqli_connect('localhost','root','root','database_name')
  or die('Erreur de communication avec la base.');
?>

<html>
<head>
    <meta charset="utf-8">
    <title>Facture INFINIVO</title>
    
    <style>
    .facture-box {
        max-width: 800px;
        margin: auto;
        padding: 30px;
        border: 1px solid #eee;
        box-shadow: 0 0 10px rgba(0, 0, 0, .15);
        font-size: 16px;
        line-height: 24px;
        font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        color: #555;
    }
    
    .facture-box table {
        width: 100%;
        line-height: inherit;
        text-align: left;
    }
    
    .facture-box table td {
        padding: 5px;
        vertical-align: top;
    }
    
    .facture-box table tr td:nth-child(3) {
        text-align: right;
    }
    
    .facture-box table tr.top table td {
        padding-bottom: 20px;
    }
    
    .facture-box table tr.top table td.title {
        font-size: 45px;
        line-height: 45px;
        color: #333;
    }
    
    .facture-box table tr.information table td {
        padding-bottom: 40px;
    }
    
    .facture-box table tr.heading td {
        background: #eee;
        border-bottom: 1px solid #ddd;
        font-weight: bold;
    }
    
    .facture-box table tr.details td {
        padding-bottom: 20px;
    }
    
    .facture-box table tr.item td{
        border-bottom: 1px solid #eee;
    }
    
    .facture-box table tr.item.last td {
        border-bottom: none;
    }
    
    .facture-box table tr.total td:nth-child(3) {
        text-align: right;
        border-top: 2px solid #eee;
        font-weight: bold;
    }
    
    @media only screen and (max-width: 600px) {
        .facture-box table tr.top table td {
            width: 100%;
            display: block;
            text-align: center;
        }
        
        .facture-box table tr.information table td {
            width: 100%;
            display: block;
            text-align: center;
        }
    }
    
    /** RTL **/
    .rtl {
        direction: rtl;
        font-family: Tahoma, 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
    }
    
    .rtl table {
        text-align: right;
    }
    
    .rtl table tr td:nth-child(2) {
        text-align: left;
    }
    </style>
</head>


<!--


Pour le moment les infos à piocher en BDD sont indiquées par [$$$$$$$$$$] dans le document.
<?php $requete = "SELECT * FROM TABLE"; echo $requete; ?>


-->


<body>
    <div class="facture-box">
        <table cellpadding="0" cellspacing="0">
            <tr class="top">
                <td colspan="3">
                    <table>
                        <tr>
                            <td class="title">
                            <img src="infinivo-logo.png" style="width:100%; max-width:300px;">
                            </td>
                            <td></td>
                            <td>
				<strong>Facture</strong>
                                Numéro&nbsp;: [$$$$$$$$$$]<br>
                                Date&nbsp;: [$$$$$$$$$$]<br>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <tr class="information">
                <td colspan="3">
                    <table>
                        <tr>
                            <td>
                                <strong>Émetteur&nbsp;:</strong>
                                Infinivo®<br>
                                114&nbsp;rue&nbsp;Lucien&nbsp;Faure<br>
                                33300&nbsp;Bordeaux<br>
                                France
                            </td>
                            <td></td>
                            <td>
                                <strong>Destinaire&nbsp;:</strong>
                                [$$$$$$$$$$]<br>
                                [$$$$$$$$$$]<br>
                                [$$$$$$$$$$]<br>
                                [$$$$$$$$$$]
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>


            
            <tr class="heading">
                <td>
                    Logiciel
                </td>
                <td>
                    Licence
                </td>
                <td>
                    Prix HT
                </td>
            </tr>


            <tr class="item">
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
            </tr>
            <tr class="item">
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
            </tr>
            <tr class="item">
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
            </tr>
            <tr class="item">
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
                <td>
                    [$$$$$$$$$$]
                </td>
            </tr>






            <tr class="total">
                <td></td>
                <td></td>
                <td>
                     Total HT&nbsp;[$$$$$$$$$$]<br>
                     TVA&nbsp;: 20%<br>
                     <hr>
                     Total TTC&nbsp;: [$$$$$$$$$$]
                </td>
            </tr>



        </table>
    </div>

    <mysqli_close($db);
    ?>

</body>
</html>
