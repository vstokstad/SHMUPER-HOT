using System.Collections.Generic;
using System.Linq;
using Actors.Player;
using UnityEngine;
using static Managers.TagsAsStrings;

namespace Managers {
    public class EnemySpawnManager : MonoBehaviour {
        [SerializeField] public int numberOfEnemies = 20;
        [SerializeField] private float timeBetweenSpawn = 3f;
        private List<GameObject> _enemiesLvl1;
        private List<GameObject> _enemiesLvl2;
        private List<GameObject> _enemiesLvl3;
        private Vector3 _enemyDirection;
        private Vector3 _initialPosition;

        private PlayerController _playerController;
        private float _playerKills;
        private float _spawnTimer = 1f;


        private float PositionY => Random.Range(max: GameManager.CameraBounds.y, min: -8);

        private float PositionX =>
            Random.Range(max: GameManager.CameraBounds.x + 10f, min: GameManager.CameraBounds.x + 2f);

        private void Awake(){
            _playerController = GameObject.FindWithTag(playerTag).GetComponent<PlayerController>();
            _enemiesLvl1 = new List<GameObject>();
            _enemiesLvl2 = new List<GameObject>();
            _enemiesLvl3 = new List<GameObject>();
            EnemyPoolFiller();
        }


       public void BatchUpdate(){
            _spawnTimer -= Time.deltaTime;

            if (_spawnTimer <= 0f) {
                Spawn();
                _spawnTimer = timeBetweenSpawn;
            }
        }

        private void Spawn(){
            if (_enemiesLvl1.Count > 0)
                foreach (GameObject enemy1 in _enemiesLvl1.Where(enemy1 => !enemy1.activeSelf)) {
                    _initialPosition.x = PositionX;
                    _initialPosition.y = PositionY;
                    enemy1.transform.position = _initialPosition;
                    enemy1.gameObject.SetActive(true);
                    _enemiesLvl1.Remove(enemy1);
                    timeBetweenSpawn -= 0.01f;
                    break;
                }

            if (_playerController.killCounter < 10f) return;

            foreach (GameObject enemy2 in _enemiesLvl2.Where(enemy2 => !enemy2.activeSelf)) {
                _initialPosition.x = PositionX;
                _initialPosition.y = PositionY;
                enemy2.transform.position = _initialPosition;
                enemy2.gameObject.SetActive(true);
                _enemiesLvl2.Remove(enemy2);
                timeBetweenSpawn -= 0.01f;
                break;
            }


            if (_enemiesLvl1.Count + _enemiesLvl2.Count > 0) return;
            foreach (GameObject enemy3 in _enemiesLvl3.Where(enemy3 => !enemy3.activeSelf)) {
                _initialPosition.x = PositionX;
                _initialPosition.y = PositionY;
                enemy3.transform.position = _initialPosition;
                enemy3.gameObject.SetActive(true);
                _enemiesLvl3.Remove(enemy3);
                if (_enemiesLvl3.Count <= 0) {
                    EnemyPoolFiller();
                    timeBetweenSpawn = 3f;
                }

                return;
            }
        }

        private void EnemyPoolFiller(){
            for (int i = 0; i < numberOfEnemies; i++) {
                _initialPosition = new Vector3(PositionX, PositionY, 0f);
                _enemiesLvl1.Add(
                    Instantiate(Resources.Load(enemyTag, typeof(GameObject)), transform, true) as GameObject);
                _enemiesLvl1[i].transform.position = _initialPosition;
            }

            for (int i = 0; i < numberOfEnemies; i++) {
                _initialPosition = new Vector3(PositionX, PositionY, 0f);

                _enemiesLvl2.Add(
                    Instantiate(Resources.Load(enemy2Path, typeof(GameObject)), transform, true) as GameObject);
                _enemiesLvl2[i].transform.position = _initialPosition;
            }

            for (int i = 0; i < numberOfEnemies; i++) {
                _initialPosition = new Vector3(PositionX, PositionY, 0f);

                _enemiesLvl3.Add(
                    Instantiate(Resources.Load(enemy3Path, typeof(GameObject)), transform, true) as GameObject);
                _enemiesLvl3[i].transform.position = _initialPosition;
            }
        }
    }
}