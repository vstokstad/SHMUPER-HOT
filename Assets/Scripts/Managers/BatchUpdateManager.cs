using System;
using Actors.Environment;
using Actors.Player;
using UnityEngine;

namespace Managers {
    public class BatchUpdateManager : MonoBehaviour {
        [SerializeField] private EnemySpawnManager _enemySpawnManager;
        [SerializeField] private SpaceJunkManager _spaceJunkManager;
        [SerializeField] private TimeManager _timeManager;
        [SerializeField] private PlayerBoundaries _playerBoundaries;
        [SerializeField] private PlayerInput _playerInput;
        [SerializeField] private PlayerController _playerController;
        [SerializeField] private PlayerMovement _playerMovement;
        [SerializeField] private ShieldControl _shieldControl;
        [SerializeField] private BackgroundController _backgroundController;

        private void Update(){
            _enemySpawnManager.BatchUpdate();
            _playerInput.BatchUpdate();
            _playerController.BatchUpdate();
            _shieldControl.BatchUpdate();
            _backgroundController.BatchUpdate();
        }

        private void FixedUpdate(){
            _spaceJunkManager.BatchFixedUpdate();
            _timeManager.BatchFixedUpdate();
            _playerBoundaries.BatchFixedUpdate();
        }
    }
}