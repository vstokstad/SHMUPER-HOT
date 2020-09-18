using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class EnemySpawnManager : MonoBehaviour {
    private const string _enemyPath = "Enemy";
    private const string _enemy2Path = "Enemy2";
    private readonly int _numberOfEnemies = 20;

    private readonly string _spawnString = "Spawn";
    private readonly float _timeBetweenSpawn = 3f;
    private List<GameObject> _enemiesLvl1;
    private List<GameObject> _enemiesLvl2;

    private Vector3 _enemyDirection;
    private Vector3 _initialPosition;

    private PlayerController _playerController;
    private float _playerKills;


    private float PositionY => Random.Range(max: GameManager.CameraBounds.y, min: -8);

    private float PositionX =>
        Random.Range(max: GameManager.CameraBounds.x + 10f, min: GameManager.CameraBounds.x + 2f);

    private void Awake(){
        _playerController = GameObject.FindWithTag("Player").GetComponent<PlayerController>();
        _playerKills = _playerController.killCounter;
        _enemiesLvl1 = new List<GameObject>();
        for (int i = 0; i < _numberOfEnemies; i++) {
            _initialPosition = new Vector3(PositionX, PositionY, 0f);
            _enemiesLvl1.Add(
                Instantiate(Resources.Load(_enemyPath, typeof(GameObject)), transform, true) as GameObject);
            _enemiesLvl1[i].transform.position = _initialPosition;
        }

        _enemiesLvl2 = new List<GameObject>();
        for (int i = 0; i < _numberOfEnemies; i++) {
            _initialPosition = new Vector3(PositionX, PositionY, 0f);

            _enemiesLvl2.Add(
                Instantiate(Resources.Load(_enemy2Path, typeof(GameObject)), transform, true) as GameObject);
            _enemiesLvl2[i].transform.position = _initialPosition;
        }
    }

    private void Start(){
        //Start spawning enemies on a timed interval.
        InvokeRepeating(_spawnString, 0.1f, _timeBetweenSpawn);
    }


    private void Spawn(){
        _playerKills = _playerController.killCounter;

        if (_enemiesLvl1.Count > 0)
            foreach (GameObject enemy1 in _enemiesLvl1.Where(enemy1 => !enemy1.activeSelf)) {
                _initialPosition.x = PositionX;
                _initialPosition.y = PositionY;
                enemy1.transform.position = _initialPosition;
                enemy1.gameObject.SetActive(true);
                _enemiesLvl1.Remove(enemy1);
                print("ENEMIES LVL1 LEFT: " + _enemiesLvl1.Count);
                break;
            }

        if (_enemiesLvl2.Count <= 0 || !(_playerKills > 10f)) return;

        foreach (GameObject enemy2 in _enemiesLvl2.Where(enemy2 => !enemy2.activeSelf)) {
            _initialPosition.x = PositionX;
            _initialPosition.y = PositionY;
            enemy2.transform.position = _initialPosition;
            enemy2.gameObject.SetActive(true);
            _enemiesLvl2.Remove(enemy2);
            print("ENEMIES LVL2 LEFT: " + _enemiesLvl2.Count);

            //If you have a high killcount there will be a HEAP of enemies spawning at once as a final boss
            if (_playerKills < 30) break;
        }
    }
}