const mysql = require('mysql');
const express = require('express');
var app = express();
var multer = require('multer');
const bodyparser = require('body-parser');

// module.exports = router;

app.use(bodyparser.json());

var mysqlConnection = mysql.createConnection({
    host:'localhost',
    user: 'root',
    password:'',
    database: 'Owner',
    multipleStatements: true
});

mysqlConnection.connect((err)=>{
    if(!err)
    console.log('DB connection succeed');
    else
    console.log('DB connection failed \n Error : '+ JSON.stringify(err,undefined, 2) );
});

app.listen(3000,()=>console.log('Express Server runs at port no:3000'));

//-----------------------// 

var storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'uploads/')
    },
    filename: function (req, file, cb) {
      cb(null, file.fieldname + '-' + Date.now() + '.jpg')
    }
  })
  
var upload = multer({ storage: storage }).single('propImage')

app.post('/propertyImage', function (req, res) {
  upload(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      // A Multer error occurred when uploading.
    }
    res.json({
       success:true,
       message:'ImageUploaded' 
    });

    // Everything went fine.
  })
});

//--------------------------------------//

var docstorage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'documents/')
    },
    filename: function (req, file, cb) {
      cb(null, file.fieldname + '-' + Date.now() + '.jpg')
    }
  })
  
var documentUpload = multer({ storage: docstorage }).single('documents')

app.post('/documentsImage', function (req, res) {
    documentUpload(req, res, function (err) {
    if (err instanceof multer.MulterError) {
      // A Multer error occurred when uploading.
    }
    res.json({
       success:true,
       message:'ImageUploaded' 
    });

    // Everything went fine.
  })
});

//----------------------------------//

//Get All Propperties
app.get('/property',(req,res)=>{
    mysqlConnection.query('SELECT * FROM property',(err, rows, fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
});

//Get An Propperties

app.get('/property/:id',(req,res)=>{
    mysqlConnection.query('SELECT * FROM property WHERE propId = ?',[req.params.id],(err, rows, fields)=>{
        if(!err)
        res.send(rows);
        else
        console.log(err);
    })
});

//Delete An Property

app.delete('/del_property/:id',(req,res)=>{
    mysqlConnection.query('DELETE FROM property WHERE propId= ?',[req.params.id],(err, rows, fields)=>{
        if(!err)
        res.send('Deleted successfully');
        else
        console.log(err);
    })
});


//Insert An Property

app.post('/new_property',(req,res)=>{
    let p = req.body;
    var sql = "SET @PropId = ?;SET @PropDetails = ?;SET @PropAddress = ?;SET @PropArea = ?;\
    SET @PropAreaD = ?;SET @PropCovered = ?;SET @PropLeaseType= ?;SET @PropServices = ?;SET @PropDocuments = ?;\
    SET @PropVerification = ?;SET @PropAvailable = ?;SET @PropImage = ?;\
    CALL PropertyAddOrEdit(@PropId,@PropDetails,@PropAddress,@PropArea,\
        @PropAreaD,@PropCovered,@PropLeaseType,@PropServices,@PropDocuments, \
        @PropVerification,@PropAvailable,@PropImage);";

    mysqlConnection.query(sql,[p.propId,p.propDetails, p.propAddress, p.propArea,p.propAreaD,p.propCovered,p.propLeaseType,p.propServices,p.propDocuments,p.propVerification,p.propAvailable,p.propImage],(err, rows, fields)=>{
        if(!err)
        rows.forEach(element => {
        
        if(element.constructor == Array)
        res.send('Inserted Property ID:'+element[0].propId);
            
        });
        else
        console.log(err);
    })

});

//Update An Property

app.put('/update_property',(req,res)=>{
    let p = req.body;
    var sql = "SET @PropId = ?;SET @PropDetails = ?;SET @PropAddress = ?;SET @PropArea = ?;\
    SET @PropAreaD = ?;SET @PropCovered = ?;SET @PropLeaseType= ?;SET @PropServices = ?;SET @PropDocuments = ?;\
    SET @PropVerification = ?;SET @PropAvailable = ?;SET @PropImage = ?;\
    CALL PropertyAddOrEdit(@PropId,@PropDetails,@PropAddress,@PropArea,\
        @PropAreaD,@PropCovered,@PropLeaseType,@PropServices,@PropDocuments, \
        @PropVerification,@PropAvailable,@PropImage);";
        mysqlConnection.query(sql,[p.propId,p.propDetails, p.propAddress, p.propArea,p.propAreaD,p.propCovered,p.propLeaseType,p.propServices,p.propDocuments,p.propVerification,p.propAvailable,p.propImage],(err, rows, fields)=>{
        
        if(!err)
        res.send('Updated Succesfully');
        else
        console.log(err);
    })
});