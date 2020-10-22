using System.Collections.Generic;
using UnityEngine;
using static Managers.TagsAsStrings;

namespace Managers {
    public class SpaceJunkManager : MonoBehaviour {
        [SerializeField] private int numberOfSpaceJunk = 15;
        private List<GameObject> _spaceJunkList;
        private float _spawnTimer;

        private void Awake(){
            _spaceJunkList = new List<GameObject>(numberOfSpaceJunk);
            for (int i = 0; i < numberOfSpaceJunk; i++) {
                _spaceJunkList.Add(Instantiate(Resources.Load(spaceJunkTag, typeof(GameObject))) as GameObject);
                _spaceJunkList[i].SetActive(false);
            }
        }


        private void FixedUpdate(){
            _spawnTimer -= Time.fixedDeltaTime;
            if (_spawnTimer <= 0f)
                if (_spaceJunkList.Count > 0)
                    for (int i = 0; i < _spaceJunkList.Count - 1; i++) {
                        if (_spaceJunkList[i].activeSelf) continue;
                        _spaceJunkList[i].gameObject.SetActive(true);
                        _spawnTimer = 1.5f;
                        break;
                    }
        }
    }
}