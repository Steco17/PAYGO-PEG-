(function() {
    // Main controller
    app.controller('MainController', ['$scope', '$rootScope', function($scope, A$rootScope) {
        $scope.authObj = Auth;
        var currentToken = localStorage.getItem('token');
        myNavigator.resetToPage('templates/login.html');


    }]); //end of MainControllerFseF
    app.controller('tabbarController', ['$scope', '$rootScope', function($scope, $rootScope) {
        $scope.authObj = Auth;
        var currentToken = localStorage.getItem('token');
        console.log("dashboard");

    }]);

    // login the post 
    app.controller("LoginController", ['$scope', '$timeout', '$rootScope',
        function($scope, $timeout, $rootScope) {
            //set Active user
            $scope.userActive = "shadowB";
            $scope.lawyerActive = "shadowA";
            $scope.loginType = true;

            $scope.openLogin = function() {
                myNavigator.pushPage('templates/dashboard.html');
            }
            //chosing user
            $scope.selectUser = function(value) {
                if (value == "user") {
                    $scope.userActive = "shadowB";
                    $scope.lawyerActive = "shadowA";
                    $scope.loginType = true;

                } else if (value == "lawyer") {
                    $scope.lawyerActive = "shadowB";
                    $scope.userActive = "shadowA";
                    $scope.loginType = false;
                }

            }
        }
    ]);
    //Home controller
    app.controller('homeController', ['$scope', 'Auth', 'UserLocationService', '$rootScope', function($scope, Auth, UserLocationService, $rootScope) {
        $scope.authObj = Auth;
        var currentToken = localStorage.getItem('token');
        console.log("dashboard");
        $scope.test = function() {
            ons.openActionSheet({
                title: 'From object',
                cancelable: true,
                buttons: [
                    'Label 0',
                    'Label 1',
                    {
                        label: 'Label 2',
                        modifier: 'destructive'
                    },
                    {
                        label: 'Cancel',
                        icon: 'md-close'
                    }
                ]
            }).then(function(index) {
                console.log('index: ', index)
            });
        }

    }]);
    //menu controller
    app.controller('menuController', ['$scope', 'Auth', 'UserLocationService', '$rootScope', function($scope, Auth, UserLocationService, $rootScope) {
        $scope.authObj = Auth;
        var currentToken = localStorage.getItem('token');
        console.log("dashboard");

    }]);





})()